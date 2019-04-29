/**
* Trigger to handle DML trigger events for Task object
* 
* @author Saurav Jaiswal
* @date 1/4/2019
*/

trigger TaskTrigger on Task (before insert, before update, after insert, after update) {

    if(Trigger_Settings__c.getInstance('TaskTrigger') != null && Trigger_Settings__c.getInstance('TaskTrigger').Is_Active__c) {
        if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate)){
            TaskTriggerHandler.updateLeadFieldAfterTaskInsert(trigger.new);
        }
    }
}