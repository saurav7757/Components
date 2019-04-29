trigger CaseTrigger on Case (before update) {
    
    if(Trigger_Settings__c.getInstance('CaseTrigger') != null && Trigger_Settings__c.getInstance('CaseTrigger').Is_Active__c) {
        if(Trigger.isBefore && Trigger.isUpdate){
            CaseTriggerHandler.validateFieldsMsg(trigger.new, Trigger.oldMap);
        }
    }
    
}