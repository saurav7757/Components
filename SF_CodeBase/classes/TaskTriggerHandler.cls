/*
*Name       : TaskTriggerHandler
*Description  : TaskTriggerHandler Handler Class is to handle the logic/methods for Task.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 

public class TaskTriggerHandler{
      
    public static void updateLeadFieldAfterTaskInsert(List<Task> tkAct) {
    Set<Id> LeadId = new Set<Id>();
    Set<Id> oppId = new Set<Id>();
    List<Date> lstDate = new List<Date>();
    List<Date> lstDateRecent = new List<Date>();
    List<Task> lstTask = new List<Task>();
    List<Lead> lstLead = new List<Lead>();
    List<Opportunity> lstOpp = new List<Opportunity>();
    List<Task> lstTaskOpp = new List<Task>();
    List<Date> lstDateOpp = new List<Date>();
    List<Date> lstDateRecentOpp = new List<Date>();
    for(Task tk : tkAct){
        if(tk.WhoId != null){
            Schema.SObjectType sobjectType = tk.WhoId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();
            if(sobjectName == 'Lead'){
                LeadId.add(tk.WhoId);
            }
        }
        if(tk.WhatId != null){
            Schema.SObjectType sobjectType = tk.WhatId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();
            if(sobjectName == 'Opportunity'){
                oppId.add(tk.WhatId);
            }
        }
    }
    if(!LeadId.isEmpty()) {
        lstLead =[SELECT Id, Upcoming_Task_Due_Date__c,Recent_Closed_Task__c FROM Lead WHERE Id IN: LeadId];
        lstTask = [SELECT Id, ActivityDate, Status FROM Task WHERE WhoId IN: LeadId];
    }
    if(!oppId.isEmpty()) {
        lstOpp =[SELECT Id, Upcoming_Task_Due_Date__c,Recent_Closed_Task_Date__c FROM Opportunity WHERE Id IN: oppId];
        lstTaskOpp = [SELECT Id, ActivityDate, Status FROM Task WHERE WhatId IN: oppId];
    }
    if(!lstTask.isEmpty()) {
        for(Task tks : lstTask){
            if(tks.Status == 'Open'){
                lstDate.add(tks.ActivityDate);
            }
            if(tks.Status == 'Completed'){
                lstDateRecent.add(tks.ActivityDate);
            }
        }
    }
    if(!lstTaskOpp.isEmpty()) {
        for(Task tkst : lstTaskOpp){
            if(tkst.Status == 'Open'){
                lstDateOpp.add(tkst.ActivityDate);
            }
            if(tkst.Status == 'Completed'){
                lstDateRecentOpp.add(tkst.ActivityDate);
            }
        }
    }
    if(!lstDate.isEmpty() && !lstDateRecent.isEmpty()){
        lstDate.sort();
        lstDateRecent.sort();
    }
    if(!lstDateOpp.isEmpty() && !lstDateRecentOpp.isEmpty()){
        lstDateOpp.sort();
        lstDateRecentOpp.sort();
    }
    if(!lstLead.isEmpty()){ 
        for(Lead ld : lstLead){
            if(!lstDate.isEmpty()){
                ld.Upcoming_Task_Due_Date__c = lstDate.get(0);
            }
            if(!lstDateRecent.isEmpty()){
                ld.Recent_Closed_Task__c = lstDateRecent.get(lstDateRecent.size()-1);
            }
        }
        update lstLead;
    }
    if(!lstOpp.isEmpty()){ 
        for(Opportunity op : lstOpp){
            if(!lstDateOpp.isEmpty()){
                op.Upcoming_Task_Due_Date__c = lstDateOpp.get(0);
            }
            if(!lstDateRecentOpp.isEmpty()){
                op.Recent_Closed_Task_Date__c = lstDateRecentOpp.get(lstDateRecentOpp.size()-1);
            }
        }
        update lstOpp;
    }
}
}