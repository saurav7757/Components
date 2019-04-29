trigger AccountTrigger on Account (before update, after update) {
    
    if(Trigger_Settings__c.getInstance('AccountTrigger') != null && Trigger_Settings__c.getInstance('AccountTrigger').Is_Active__c) {
        if(Trigger.isBefore && Trigger.isUpdate){
            AccountTriggerHandler.UpdateReleasedOnbMgrCount (trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.updateFirstShareDetailsOnOpp (trigger.new, Trigger.oldMap);
            AccountTriggerHandler.generateRefferalCode(trigger.new, Trigger.oldMap);
            AccountTriggerHandler.validateFirstShrHolAsRelCont(trigger.new, Trigger.oldMap);
            AccountTriggerHandler.validateFirstZGAsRelCont(trigger.new, Trigger.oldMap);
              //AccountTriggerHandler.updateFieldsOnOpp(trigger.new, Trigger.oldMap);
        }
        if(Trigger.isAfter && Trigger.isUpdate){
            //AccountTriggerHandler.UpdateReleasedOnbMgrCount (trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.updateFirstZGDetailsOnOpp(trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.updateFirstShareDetailsOnOpp(trigger.new, Trigger.oldMap);
            //AccountTriggerHandler.updateFieldsOnOpp(trigger.new, Trigger.oldMap);
            AccountTriggerHandler.sendAccountDetailsToDjango(trigger.new, Trigger.oldMap);
        }
    }
    
}