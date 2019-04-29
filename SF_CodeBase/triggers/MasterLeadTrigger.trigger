trigger MasterLeadTrigger on Lead (
    before insert, after insert,
    before update, after update,
    before delete, after delete) {
        
       if(Trigger_Settings__c.getInstance('LeadTrigger') != null && Trigger_Settings__c.getInstance('LeadTrigger').Is_Active__c)  {
        if (Trigger.isBefore) {
                
            if (Trigger.isInsert) { 
              AssignmentGroup_LeadRoundRobin.AssignLead(false, Trigger.new, Trigger.oldMap);
            }
            if (Trigger.isUpdate) { 
              AssignmentGroup_LeadRoundRobin.AssignLead(true, Trigger.new, Trigger.oldMap);
            }
            if (Trigger.isDelete) { }
        }
        
        if (Trigger.IsAfter) {
            if (Trigger.isInsert) { }
            if (Trigger.isUpdate) { }
            if (Trigger.isDelete) { }
        }
    }
        
    }