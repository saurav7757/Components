/*
*Name       : ONBMgrAvailabilityTriggerHandler 
*Description  : ONBMgrAvailabilityTriggerHandler Handler Class is to handle the logic/methods for ONB.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 



public class ONBMgrAvailabilityTriggerHandler {
    public static void UpdateRemainingAvalMgrCount (List<Onboarding_Manager_Availability__c> onbListNew, Map<Id,Onboarding_Manager_Availability__c> onbMapOld){
        Decimal diffRange;
        for(Onboarding_Manager_Availability__c onb : onbListNew){
        Onboarding_Manager_Availability__c oldOnb = onbMapOld.get(onb.Id);
        if(onb.Total_Capacity__c != oldOnb.Total_Capacity__c){
            diffRange = oldOnb.Total_Capacity__c - onb.Total_Capacity__c;
            onb.Remaining_Capacity__c = onb.Remaining_Capacity__c - diffRange;
        }
        
        }
    }
}