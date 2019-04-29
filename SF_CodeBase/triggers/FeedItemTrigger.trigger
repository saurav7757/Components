trigger FeedItemTrigger on FeedItem (before insert,after insert,before update,after update) {
    
    if(Trigger_Settings__c.getInstance('FeedItemTrigger') != null && Trigger_Settings__c.getInstance('FeedItemTrigger').Is_Active__c) {
        if(Trigger.isBefore && Trigger.isInsert){
            FeedItemTriggerHandler.changeFeedItemType(trigger.new, Trigger.oldMap);
        }
   }
    
}