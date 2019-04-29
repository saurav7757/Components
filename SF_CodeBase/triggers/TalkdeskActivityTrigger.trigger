/**
* Trigger to handle DML trigger events for Talkdesk_Activity__c object
* 
* @author Saurav Jaiswal
* @date 10/24/2017
*/

trigger TalkdeskActivityTrigger on talkdesk__Talkdesk_Activity__c (before insert, before update, after insert, after update) {

    if(Trigger_Settings__c.getInstance('TalkDeskActivityTrigger') != null && Trigger_Settings__c.getInstance('TalkDeskActivityTrigger').Is_Active__c) {
        if((Trigger.isAfter && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate)){
            TalkdeskActivityTriggerHandler.insertActivityAfterTalkDesk(trigger.new);
        }
    }
}