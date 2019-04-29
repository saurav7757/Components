trigger ONBTrigger on Onboarding_Manager_Availability__c (before update) {
    
   if(Trigger_Settings__c.getInstance('ONBMgrTrigger') != null && Trigger_Settings__c.getInstance('ONBMgrTrigger').Is_Active__c){
       if(Trigger.isBefore && Trigger.isUpdate){
           ONBMgrAvailabilityTriggerHandler.UpdateRemainingAvalMgrCount(trigger.new, trigger.oldMap);
       }
   }
}