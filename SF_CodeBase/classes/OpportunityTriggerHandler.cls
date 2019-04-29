/*
*Name       : OpportunityTriggerHandler 
*Description  : OpportunityTriggerHandler Handler Class is to handle the logic/methods for Opportunity.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 



public class OpportunityTriggerHandler {

    /*public static void assignOnboardingManager(List<Opportunity> oppList){
        Set<Id> accountIDS = new Set<Id>();
        Set<Id> sameOnbMgr = new Set<Id>();
        String preferredLang;
        Integer liveMonth;
        Integer liveYear;
        Decimal maxvalue;
        List<Account> accToUpdateOverCap = new List<Account>();
        String defaultOwnerId = [select id from User where name = 'Friederike Loeper'].id;
        Map<Integer,Integer> intMaximumMap = new Map<Integer,Integer>();
        List<Integer> intMaximum = new List<Integer>();
        List<Decimal> relativeCapLstToCalc = new List<Decimal>();
        Map<Decimal,Id> relativeCapLst = new Map<Decimal,Id>();
        Map<Decimal,Id> mapToHoldAccIdAndOnbId = new Map<Decimal,Id>();
        List<Account> accToUpdate = new List<Account>();
        map<id,account> accmap = new map<id,account>();
        List<Onboarding_Manager_Availability__c> onbmgravailabilityToUpdate = new List<Onboarding_Manager_Availability__c>();
        map<id,Onboarding_Manager_Availability__c> onbMap = new map<id,Onboarding_Manager_Availability__c>();
        List<Onboarding_Manager_Availability__c> onbmgravailabilityToUpdateNew = new List<Onboarding_Manager_Availability__c>();
        map<id,Onboarding_Manager_Availability__c> onbMapNew = new map<id,Onboarding_Manager_Availability__c>();
        map<id,Account> onbMapNewOverCap = new map<id,Account>();
        Set<Id> firstShrhlId = new Set<Id>();
        for(Opportunity opp : oppList){
            if(opp.Ready_to_Handover__c == true && opp.StageName == 'Closed Won'){
                accountIDS.add(opp.AccountId);
                liveMonth = opp.Go_Live_Date__c.month();
                liveYear = opp.Go_Live_Date__c.year();
            }
        }
        if(!accountIDS.isEmpty()){
            //List<Contact> lstCont = [Select Id, Name, Language__c From Contact where AccountId IN: accountIDS];
            List<Account> lstAcc = [SELECT Id, Onboarding_Manager__c,First_Shareholder__c FROM Account WHERE Id IN: accountIDS];
            for(Account acc : lstAcc){
                if(acc.First_Shareholder__c != null){
                    firstShrhlId.add(acc.First_Shareholder__c);
                }
            }
            List<Contact> lstCont = [Select Id, Name, Language__c From Contact where Id IN: firstShrhlId];
            if(lstCont[0].Language__c != null || lstCont[0].Language__c != ''){
                preferredLang = lstCont[0].Language__c;
            }
            List<Onboarding_Manager_Availability__c> onbmgravailability = [SELECT Id,Language__c, Month__c, Related_Onboarding_Manager__c,Remaining_Capacity__c ,Total_Capacity__c 
                                                                            FROM Onboarding_Manager_Availability__c WHERE Language__c includes(:preferredLang)];
            if(!onbmgravailability.isEmpty()) {
                for(Onboarding_Manager_Availability__c oma : onbmgravailability){
                    if(oma.Month__c.month() == liveMonth && oma.Month__c.year() == liveYear){
                        if(oma.Remaining_Capacity__c != 0 && oma.Remaining_Capacity__c != null){
                            Decimal relativeCap = ((oma.Remaining_Capacity__c / oma.Total_Capacity__c) * 100) ;
                            relativeCapLstToCalc.add(relativeCap);
                            
                            
                            
                            if(!relativeCapLst.containsKey(relativeCap) && !mapToHoldAccIdAndOnbId.containsKey(relativeCap)){
                                intMaximumMap.put(relativeCap.intValue(),oma.Total_Capacity__c.intValue());
                                mapToHoldAccIdAndOnbId.put(relativeCap,oma.Id);
                                relativeCapLst.put(relativeCap,oma.Related_Onboarding_Manager__c);
                            }else if(relativeCapLst.containsKey(relativeCap) && mapToHoldAccIdAndOnbId.containsKey(relativeCap) && (intMaximumMap.get(relativeCap.intValue()) < oma.Total_Capacity__c)){
                                system.debug('##00' +intMaximumMap.get(relativeCap.intValue()));
                                system.debug('##000' +oma.Total_Capacity__c);
                                system.debug('##0' +intMaximumMap);
                                intMaximumMap.remove(relativeCap.intValue());
                                intMaximumMap.put(relativeCap.intValue(),oma.Total_Capacity__c.intValue());
                                mapToHoldAccIdAndOnbId.remove(relativeCap);
                                system.debug('##1' +mapToHoldAccIdAndOnbId);
                                mapToHoldAccIdAndOnbId.put(relativeCap,oma.Id);
                                system.debug('##2' +mapToHoldAccIdAndOnbId);
                                relativeCapLst.remove(relativeCap);
                                system.debug('##3' +relativeCapLst);
                                relativeCapLst.put(relativeCap,oma.Related_Onboarding_Manager__c);
                                system.debug('##4' +relativeCapLst);
                                //relativeCapLst.put(relativeCap,oma.Related_Onboarding_Manager__c);
                                
                                
                            }
                        }
                    }
                }
                if(relativeCapLstToCalc.isEmpty()){
                    for(Opportunity opp : oppList){
                        //opp.addError('There is no Onboarding Manager available with given go-live date and/or with preferred language.');
                    }
                }
                
                if(!relativeCapLstToCalc.isEmpty()){
                    maxvalue = relativeCapLstToCalc[0];
                    for (integer i =0;i<relativeCapLstToCalc.size();i++){
                        if(relativeCapLstToCalc[i] > maxvalue){
                            maxvalue = relativeCapLstToCalc[i];
                        }
                    }
                }
            } 
            if(!lstAcc.isEmpty()){
                for(Account acc : lstAcc){
                    if(acc.Onboarding_Manager__c == null) {
                        if(relativeCapLst.size() > 0){
                            acc.Onboarding_Manager__c = relativeCapLst.get(maxvalue);
                            accToUpdate.add(acc);
                        } else if(relativeCapLst.size() == 0){
                            acc.Onboarding_Manager__c = defaultOwnerId;
                            accToUpdateOverCap.add(acc);
                        }
                    }else if(acc.Onboarding_Manager__c != null){
                            sameOnbMgr.add(acc.Onboarding_Manager__c);
                    }
                }
            }   
            if(!accToUpdate.isEmpty() && !mapToHoldAccIdAndOnbId.isEmpty()){
                for(Onboarding_Manager_Availability__c omab : [SELECT Id,Remaining_Capacity__c FROM Onboarding_Manager_Availability__c WHERE Id =: mapToHoldAccIdAndOnbId.get(maxvalue)]){
                    omab.Remaining_Capacity__c = omab.Remaining_Capacity__c - 1;
                    onbmgravailabilityToUpdate.add(omab);
                }
                   
                accmap.putall(accToUpdate);
                if(accmap.size()>0){
                    Database.SaveResult[] srList = Database.update(accmap.values(), false);
                    for(Database.SaveResult sr : srList) {
                        if(sr.isSuccess()) {
                            onbMap.putall(onbmgravailabilityToUpdate);
                        }
                    }
                }
                if(onbMap.size()>0){
                    update onbMap.values();
                }
            }else if(!sameOnbMgr.isEmpty() && accToUpdate.isEmpty()){
                for(Onboarding_Manager_Availability__c omabt : [SELECT Id,Language__c, Month__c, Related_Onboarding_Manager__c,Remaining_Capacity__c ,Total_Capacity__c FROM Onboarding_Manager_Availability__c WHERE Related_Onboarding_Manager__c IN: sameOnbMgr AND Language__c includes (:preferredLang)]){
                    if(omabt.Month__c.month() == liveMonth && omabt.Month__c.year() == liveYear) {
                        if(omabt.Remaining_Capacity__c != 0 && omabt.Remaining_Capacity__c != null) {
                            //omabt.Remaining_Capacity__c = omabt.Remaining_Capacity__c - 1;
                            //onbmgravailabilityToUpdateNew.add(omabt);
                        }
                    }
                }
            }
            if(!onbmgravailabilityToUpdateNew.isEmpty()){
                onbMapNew.putall(onbmgravailabilityToUpdateNew);
                if(onbMapNew.size()>0){
                    update onbMapNew.values();
                }   
            }
            
            if(!accToUpdateOverCap.isEmpty()){
                onbMapNewOverCap.putall(accToUpdateOverCap);
                if(onbMapNewOverCap.size()>0){
                    update onbMapNewOverCap.values();
                }   
            }
        }
    }*/
    
    /*public static void updateAccReferralDates(List<Opportunity> oppLst) {
        Set<Id> accIDS = new Set<Id>();
        Map<Id,Date> mpOfAccIdandClosedDate = new Map<Id,Date>();
        Map<Id,Date> mpOfAccIdandGoLiveDate = new Map<Id,Date>();
        List<Referrals__c> refsToUpdate = new List<Referrals__c>();
        List<Referrals__c> lstRefsToUpdate = new List<Referrals__c>();
        for(Opportunity opp : oppLst){
            if(opp.Ready_to_Handover__c == true && opp.StageName == 'Closed Won'){
                accIDS.add(opp.AccountId);
                mpOfAccIdandClosedDate.put(opp.AccountId,opp.CloseDate);
                mpOfAccIdandGoLiveDate.put(opp.AccountId,opp.Go_Live_Date__c);
            }
        }
        if(!accIDS.isEmpty()){
            lstRefsToUpdate = [SELECT Id,Go_Live_Date__c,Closed_Won_Date__c,Referral_Company__c FROM Referrals__c WHERE Referral_Company__c IN : accIDS];
        }
        if(!lstRefsToUpdate.isEmpty()){
            for(Referrals__c rc : lstRefsToUpdate){
                rc.Closed_Won_Date__c = mpOfAccIdandClosedDate.get(rc.Referral_Company__c);
                rc.Go_Live_Date__c = mpOfAccIdandGoLiveDate.get(rc.Referral_Company__c);
                refsToUpdate.add(rc);
            }
        }
        if(!refsToUpdate.isEmpty()){
            update refsToUpdate;
        }
        
    }*/
    
    public static void updateZeitGoldCustomerNumber(List<Opportunity> oppLst) {
        Set<Id> accIDS = new Set<Id>();
        List<Account> lstAccToUpdate = new List<Account>();
        List<Account> lstAcc = new List<Account>();
        Integer ZGCurrentCustNumber;
        Boolean isSuccessUpdate = false;
        for(Opportunity opp : oppLst){
            if(opp.Ready_to_Handover__c == true && opp.StageName == 'Closed Won'){
                accIDS.add(opp.AccountId);
            }
        }
        if(!accIDS.isEmpty()){
            lstAcc = [SELECT Id,Zeitgold_Customer_No__c FROM Account WHERE Id IN : accIDS];
            ZGCurrentCustNumber = double.valueOf(ZG_Customer_Number__c.getValues('Customer_Number').Current_Number__c).intValue();
        }
        if(!lstAcc.isEmpty()){
            for(Account acc : lstAcc){
                if(acc.Zeitgold_Customer_No__c == null){
                    acc.Zeitgold_Customer_No__c = ZGCurrentCustNumber + 1;
                    lstAccToUpdate.add(acc);
                }
            }
        }
        if(!lstAccToUpdate.isEmpty()){
             Database.saveResult[] rslt = Database.update(lstAccToUpdate,false);
             for(Database.saveResult r: rslt){
                if(r.isSuccess()){
                    isSuccessUpdate = true;
                }
            }
        }
        if(isSuccessUpdate){
            ZG_Customer_Number__c ZGNo = ZG_Customer_Number__c.getValues('Customer_Number');
            ZGNo.Current_Number__c = ZGCurrentCustNumber + 1;
            update ZGNo;
        }
        
    }
}