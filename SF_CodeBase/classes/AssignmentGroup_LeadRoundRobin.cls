public class AssignmentGroup_LeadRoundRobin {

    public static void AssignLead(boolean IsUpdate, List<Lead> Leads, Map<Id, Lead> oldMap_Leads){
        //
        //Check if assignment owner has changed
        //
        Map<Integer,Id> queueIds = new Map<Integer,Id>();   //Trigger index --> Queue ID
        
        Integer idx = 0;
        for (lead l : Leads)
        {
            if(IsUpdate) {  
                if(l.OwnerId <> oldMap_Leads.get(l.id).OwnerId) {
                    if (l.TempOwnerId__c == 'SKIP') {
                        Leads[idx].TempOwnerId__c = '';
                    } else {
                        queueIds.put(idx, l.OwnerId);
                    }
                }           
            }else {
                queueIds.put(idx, l.OwnerId);
            }   
            idx++;
        }
        System.debug('>>>>>queueIds: '+queueIds);
        if (queueIds.isEmpty()) return;
        
        //
        //Find active Assignment Group for Queue
        //
        Map<Integer,Id> asgnGroupNameIds = new Map<Integer,Id>();   //Trigger index --> Assignment_Group_Name ID
        Map<Id,Assignment_Group_Queues__c> asgnGroupQueues = new Map<Id,Assignment_Group_Queues__c>(); //Queue ID --> Assignment Group Queues
        
        for(Assignment_Group_Queues__c[] agq : [SELECT Assignment_Group_Name__c, QueueId__c
                                              FROM Assignment_Group_Queues__c 
                                              WHERE QueueId__c in :queueIds.values()
                                              AND Active__c = 'True'])
        {
            for (Integer i = 0; i < agq.size() ; i++) {
                asgnGroupQueues.put(agq[i].QueueId__c, agq[i]);
            }                                           
        }
        System.debug('>>>>>asgnGroupQueues: '+asgnGroupQueues); 
        if (asgnGroupQueues.isEmpty()) return;
    
        for (Integer i : queueIds.keySet()) {
            Assignment_Group_Queues__c agq = asgnGroupQueues.get(queueIds.get(i));
            
            if (agq <> null) {
                asgnGroupNameIds.put(i, agq.Assignment_Group_Name__c);
            }
            //else no active assignment group queue error
        }
        System.debug('>>>>>asgnGroupNameIds: '+asgnGroupNameIds);
        if (asgnGroupNameIds.isEmpty()) return;
        
        //
        //Determine next valid user in Queue/Assignment Group for round robin
        //User with earliest last assignment date wins.
        //
        Map<Id,Assignment_Groups__c[]> asgnGroups = new Map<Id,Assignment_Groups__c[]>(); // Assignment Group Name ID --> User ID
        for(Assignment_Groups__c[] ags : [SELECT Group_Name__c, User__c, Last_Assignment__c, Millisecond__c 
                                       FROM Assignment_Groups__c 
                                       WHERE Group_Name__c in :asgnGroupNameIds.values() 
                                       AND Active__c = 'True' AND User_Active__c = 'True'
                                       ORDER BY Last_Assignment__c, Millisecond__c])
        {
            /* 
            Start Ryan Schwartz (RS) Edit
            source: https://dl.dropboxusercontent.com/u/53527196/sfdc/leadRoundRobin.trigger.txt
            This edit helps resolve some of the NullPointerException errors.
            */
            /* 
            if (ags.size()>0) {
                asgnGroups.put(ags[0].Group_Name__c, ags);
            }
            */
            if (ags.size()>0) {     
                Assignment_Groups__c[] tmpAssignGroups = new List<Assignment_Groups__c>();
                String tmpGroupName = ags[0].Group_Name__c;
                for (Integer i = 0; i < ags.size() ; i++) {
                    
                    // If the group has changed reset the list
                    if(ags[i].Group_Name__c <> tmpGroupName){
                        tmpGroupName = ags[i].Group_Name__c;
                        tmpAssignGroups = new List<Assignment_Groups__c>();
                    }
                    // Always add members who belong to the current group name to a temp array
                    tmpAssignGroups.add(ags[i]);
                    asgnGroups.put(ags[i].Group_Name__c, tmpAssignGroups);
                }
            }
            /* End RS Edit */
        }
        System.debug('>>>>>asgnGroups: '+asgnGroups);   
        if (asgnGroups.isEmpty()) return;
    
        Map<Id,Assignment_Groups__c> updateAssignmentGroups = new Map<Id,Assignment_Groups__c>();
        Map<Id, datetime> latestAGDateTime = new Map<Id,datetime>();
        idx = 0;    
        for (Integer i : queueIds.keySet())
        {
            Assignment_Groups__c[] ags = asgnGroups.get(asgnGroupNameIds.get(i));
            if(ags != null) //This edit helps resolve some of the NullPointerException errors.
            {
                if (ags.size()>0)
                {   
                    //Choose next user in line if user ID has already been used but not committed in this trigger batch 
                    Assignment_Groups__c ag = ags[math.mod(idx, ags.size())];

                    //Assign User to lead as the new owner
                    System.debug('>>>>>Owner changed for lead ' + Leads[i].Id + ' from '+Leads[i].OwnerId+' to '+ ag.User__c);
                    Leads[i].OwnerId = ag.User__c;    
                    Leads[i].TempOwnerId__c = ag.User__c; 

                    //Set last assignment datetime
                    datetime now = datetime.now();
                    ag.Last_Assignment__c = now;
                    ag.Millisecond__c = now.millisecondGMT();

                    //update only latest Assignment Groups per ID
                    if (latestAGDateTime.containsKey(ag.id)) {
                        if(latestAGDateTime.get(ag.id) < now) {
                            updateAssignmentGroups.put(ag.id, ag);
                            latestAGDateTime.put(ag.id, now);
                        }
                    } else {
                        updateAssignmentGroups.put(ag.id, ag);
                        latestAGDateTime.put(ag.id,now);
                    }

                    idx++;
                }
            }
        }
        //Map --> List/Array for DML update
        List<Assignment_Groups__c> updateAG = new List<Assignment_Groups__c>();
        for (Id agId : updateAssignmentGroups.keySet()) {
            updateAG.add(updateAssignmentGroups.get(agId));
        }
    
        System.debug('>>>>>Update Assignment Groups: '+updateAG);   
        
        //
        //Update last assignment for Assignment Group in batch
        //
        if (updateAG.size()>0) {
            try {
                update updateAG;
            } catch (Exception e){
                for (Integer i : queueIds.keySet())
                {
                    Trigger.new[i].addError('ERROR: Could not update Assignment Group records ' + ' DETAIL: '+e.getMessage());  
                }
            }
        }
    }
}