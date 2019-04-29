trigger OpportunityTrigger on Opportunity (before update, after update) {
    
    if(Trigger_Settings__c.getInstance('OpportunityTrigger') != null && Trigger_Settings__c.getInstance('OpportunityTrigger').Is_Active__c) {
        if(Trigger.isAfter && Trigger.isUpdate){
            //OpportunityTriggerHandler.assignOnboardingManager(trigger.new);
            //OpportunityTriggerHandler.updateAccReferralDates(trigger.new);
            OpportunityTriggerHandler.updateZeitGoldCustomerNumber(trigger.new);
        }
    }
    
}