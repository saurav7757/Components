/*
*Name       : AccountTriggerHandler 
*Description  : AccountTriggerHandler Handler Class is to handle the logic/methods for Account.
*Author    : Saurav Jaiswal
*Date      : 1/3/20122
*
*MODIFICATION LOG:
*DEVELOPER  Name                       DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 



public class AccountTriggerHandler {

    public static void UpdateReleasedOnbMgrCount (List<Account> accList, Map<Id,Account> mapOldAcc){
        
        Set<Id> mgrToUpdate = new Set<Id>();
        Set<Id> newMgrToUpdate = new Set<Id>();
        Set<Id> accId = new Set<Id>();
        List<Date> goLiveDate = new List<Date>();
        List<String> preferredLang = new List<String>();
        List<Onboarding_Manager_Availability__c> onbMgrDetails = new List<Onboarding_Manager_Availability__c>();
        List<Onboarding_Manager_Availability__c> onbmgravailabilityToUpdateNew = new List<Onboarding_Manager_Availability__c>();
        map<id,Onboarding_Manager_Availability__c> onbMapNew = new map<id,Onboarding_Manager_Availability__c>();
        List<Onboarding_Manager_Availability__c> onbmgravailabilityToUpdateNewRel = new List<Onboarding_Manager_Availability__c>();
        map<id,Onboarding_Manager_Availability__c> onbMapNewRel = new map<id,Onboarding_Manager_Availability__c>();
        Set<Id> firstShrhlId = new Set<Id>();
        for (Account acc: accList) {
            Account oldAccount = mapOldAcc.get(acc.ID);
            if((acc.Onboarding_Manager__c != oldAccount.Onboarding_Manager__c) && acc.Onboarding_Manager__c != null && oldAccount.Onboarding_Manager__c != null) {
                newMgrToUpdate.add(acc.Onboarding_Manager__c);
                mgrToUpdate.add(oldAccount.Onboarding_Manager__c);
                accId.add(acc.Id);
            }
        }
        if(!accId.isEmpty()){
            List<Opportunity> oppLst = [SELECT Id, Go_Live_Date__c FROM Opportunity WHERE AccountId IN: accId];
            List<Account> accLst = [SELECT Id, First_ZG_Contact__c FROM Account WHERE Id IN: accId];
            if(!accLst.isEmpty()){
                for(Account con : accLst){
                    firstShrhlId.add(con.First_ZG_Contact__c);
                    //preferredLang.add(con.Language__c);
                }
                if(!firstShrhlId.isEmpty()){
                    List<Contact> conList = [SELECT Id, Language__c FROM Contact WHERE Id IN: firstShrhlId];
                    if(conList[0].Language__c != null || conList[0].Language__c != ''){
                        preferredLang.add(conList[0].Language__c);
                    }
                }
            }
            if(!oppLst.isEmpty()){
                for(Opportunity opp : oppLst){
                    goLiveDate.add(opp.Go_Live_Date__c);
                }
            }
        }
        if(!preferredLang.isEmpty()){
            onbMgrDetails = [SELECT Id,Language__c, Month__c, Related_Onboarding_Manager__c,Remaining_Capacity__c ,Total_Capacity__c 
                                                                                FROM Onboarding_Manager_Availability__c WHERE Language__c includes(:preferredLang[0])];
        }
        System.debug('Test1' + onbMgrDetails);
        if(!onbMgrDetails.isEmpty() && !goLiveDate.isEmpty()) {
            for(Onboarding_Manager_Availability__c onb : onbMgrDetails){
                for(Date dt : goLiveDate){
                    if(!mgrToUpdate.isEmpty() && mgrToUpdate.contains(onb.Related_Onboarding_Manager__c)){
                        if(dt != null && (dt.month() == onb.Month__c.month()) && (dt.year() == onb.Month__c.year())) {
                            onb.Remaining_Capacity__c = onb.Remaining_Capacity__c + 1;
                            onbmgravailabilityToUpdateNew.add(onb);
                            System.debug('Test2' + onbmgravailabilityToUpdateNew);
                        }
                    } else if(!newMgrToUpdate.isEmpty() && newMgrToUpdate.contains(onb.Related_Onboarding_Manager__c)){
                        if(dt != null && (dt.month() == onb.Month__c.month()) && (dt.year() == onb.Month__c.year())) {
                            onb.Remaining_Capacity__c = onb.Remaining_Capacity__c - 1;
                            onbmgravailabilityToUpdateNewRel.add(onb);
                            System.debug('Test3' + onbmgravailabilityToUpdateNewRel);
                        }
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
        if(!onbmgravailabilityToUpdateNewRel.isEmpty()){
            onbMapNewRel.putall(onbmgravailabilityToUpdateNewRel);
            if(onbMapNewRel.size()>0){
                update onbMapNewRel.values();
            }
        }
    }
    
    /*public static void updateFirstShareDetailsOnOpp(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        
        Set<Id> lstContact = new Set<Id>();
        List<Id> lstAcc = new List<Id>();
        List<Opportunity> lstOppUpdate = new List<Opportunity>();
        map<Id,String> mapSal = new map<Id,String>();
        map<Id,String> toneAddr = new map<Id,String>();
        map<Id,String> firName = new map<Id,String>();
        map<Id,String> lstName = new map<Id,String>();
        map<Id,String> phne = new map<Id,String>();
        map<Id,String> emlCon = new map<Id,String>();
        map<Id,String> titleZG1 = new map<Id,String>();
        map<Id,String> prfLang = new map<Id,String>();
        Map<Id,Id> mapofShrHolder = new Map<Id,Id>();
        List<Contact> lstCon = new List<Contact>();
        List<Opportunity> lstOpp = new List<Opportunity>();
        for(Account acc : accLst){
            if(acc.First_Shareholder__c != null && mapOldAccnt.get(acc.ID).First_Shareholder__c != acc.First_Shareholder__c){
                lstContact.add(acc.First_Shareholder__c);
                lstAcc.add(acc.Id);
            }else if(acc.First_Shareholder__c == null){
                lstAcc.add(acc.Id);
            }
        }
        if(!lstContact.isEmpty()){
            lstCon = [SELECT Id,AccountId,Salutation,Tone_of_address__c,FirstName,LastName,Phone,Email,Title,Language__c,(SELECT AccountId FROM AccountContactRelations WHERE AccountId =: lstAcc[0]) FROM Contact WHERE Id IN : lstContact];
        }
        if(!lstCon.isEmpty()){
            for(Contact ct : lstCon){
                if(!ct.AccountContactRelations.isEmpty()){
                    for(AccountContactRelation acr : ct.AccountContactRelations){
                        mapofShrHolder.put(acr.AccountId,ct.Id);
                        mapSal.put(acr.AccountId,ct.Salutation);
                        toneAddr.put(acr.AccountId,ct.Tone_of_address__c);
                        firName.put(acr.AccountId,ct.FirstName);
                        lstName.put(acr.AccountId,ct.LastName);
                        phne.put(acr.AccountId,ct.Phone);
                        emlCon.put(acr.AccountId,ct.Email);
                        titleZG1.put(acr.AccountId,ct.Title);
                        prfLang.put(acr.AccountId,ct.Language__c);
                    }
                }
            }
        }
        if(!lstAcc.isEmpty()){
            lstOpp = [SELECT Id,AccountId,Ac_Salutation__c,Ac_Tone_of_address__c,Ac_First_name_ZG_1st_Contact_Person__c,Ac_Surname_ZG_1st_Contact_Person__c,Ac_Tel_of_1st_ZG_Contact__c,Ac_Email_of_1st_ZG_Contact__c,Ac_Function_in_company_of_1st_ZG_Contact__c,Ac_Preferred_Language_of_1st_ZG_Contact__c FROM Opportunity WHERE AccountId IN: lstAcc AND StageName != 'Closed Lost'];
        }
        if(!lstOpp.isEmpty()){
            for(Opportunity opp : lstOpp){
                opp.Ac_First_Shareholder__c = mapofShrHolder.get(opp.AccountId);
                opp.Ac_Salutation__c = mapSal.get(opp.AccountId);
                opp.Ac_Tone_of_address__c = toneAddr.get(opp.AccountId);
                opp.Ac_First_name_ZG_1st_Contact_Person__c = firName.get(opp.AccountId);
                opp.Ac_Surname_ZG_1st_Contact_Person__c = lstName.get(opp.AccountId);
                opp.Ac_Tel_of_1st_ZG_Contact__c = phne.get(opp.AccountId);
                opp.Ac_Email_of_1st_ZG_Contact__c = emlCon.get(opp.AccountId);
                opp.Ac_Function_in_company_of_1st_ZG_Contact__c = titleZG1.get(opp.AccountId);
                opp.Ac_Preferred_Language_of_1st_ZG_Contact__c = prfLang.get(opp.AccountId);
                lstOppUpdate.add(opp);
            }
        }
        if(!lstOppUpdate.isEmpty()){
            update lstOppUpdate;
        }
    }
    
    public static void updateFirstZGDetailsOnOpp(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        
        Set<Id> lstContact = new Set<Id>();
        List<Id> lstAcc = new List<Id>();
        List<Opportunity> lstOppUpdate = new List<Opportunity>();
        map<Id,String> mapSal = new map<Id,String>();
        map<Id,String> toneAddr = new map<Id,String>();
        map<Id,String> firName = new map<Id,String>();
        map<Id,String> lstName = new map<Id,String>();
        map<Id,String> phne = new map<Id,String>();
        map<Id,String> emlCon = new map<Id,String>();
        map<Id,String> titleZG1 = new map<Id,String>();
        map<Id,String> prfLang = new map<Id,String>();
        Map<Id,Id> mapofShrHolder = new Map<Id,Id>();
        List<Contact> lstCon = new List<Contact>();
        List<Opportunity> lstOpp = new List<Opportunity>();
        for(Account acc : accLst){
            if(acc.First_ZG_Contact__c != null && mapOldAccnt.get(acc.ID).First_ZG_Contact__c != acc.First_ZG_Contact__c){
                lstContact.add(acc.First_ZG_Contact__c);
                lstAcc.add(acc.Id);
            }else if(acc.First_ZG_Contact__c == null){
                lstAcc.add(acc.Id);
            }
        }
        if(!lstContact.isEmpty()){
            lstCon = [SELECT Id,AccountId,Salutation,Tone_of_address__c,FirstName,LastName,Phone,Email,Title,Language__c,(SELECT AccountId FROM AccountContactRelations WHERE AccountId =: lstAcc[0]) FROM Contact WHERE Id IN : lstContact];
        }
        if(!lstCon.isEmpty()){
            for(Contact ct : lstCon){
                if(!ct.AccountContactRelations.isEmpty()){
                    for(AccountContactRelation acr : ct.AccountContactRelations){
                        mapofShrHolder.put(acr.AccountId,ct.Id);
                        mapSal.put(acr.AccountId,ct.Salutation);
                        toneAddr.put(acr.AccountId,ct.Tone_of_address__c);
                        firName.put(acr.AccountId,ct.FirstName);
                        lstName.put(acr.AccountId,ct.LastName);
                        phne.put(acr.AccountId,ct.Phone);
                        emlCon.put(acr.AccountId,ct.Email);
                        titleZG1.put(acr.AccountId,ct.Title);
                        prfLang.put(acr.AccountId,ct.Language__c);
                    }
                }
            }
        }
        if(!lstAcc.isEmpty()){
            lstOpp = [SELECT Id,AccountId,Salutation_of_first_ZG_Contact__c,First_name_of_first_ZG_Contact__c,Surname_of_first_ZG_Contact__c,Phone_of_first_ZG_Contact__c,Email_of_first_ZG_Contact__c,Function_in_company_of_first_ZG_Contact__c,Preferred_Language_of_first_ZG_Contact__c,Tone_of_address_for_first_ZG_Contact__c FROM Opportunity WHERE AccountId IN: lstAcc AND StageName != 'Closed Lost'];
        }
        if(!lstOpp.isEmpty()){
            for(Opportunity opp : lstOpp){
                opp.First_ZG_Contact__c = mapofShrHolder.get(opp.AccountId);
                opp.Salutation_of_first_ZG_Contact__c = mapSal.get(opp.AccountId);
                opp.Tone_of_address_for_first_ZG_Contact__c = toneAddr.get(opp.AccountId);
                opp.First_name_of_first_ZG_Contact__c = firName.get(opp.AccountId);
                opp.Surname_of_first_ZG_Contact__c = lstName.get(opp.AccountId);
                opp.Phone_of_first_ZG_Contact__c = phne.get(opp.AccountId);
                opp.Email_of_first_ZG_Contact__c = emlCon.get(opp.AccountId);
                opp.Function_in_company_of_first_ZG_Contact__c = titleZG1.get(opp.AccountId);
                opp.Preferred_Language_of_first_ZG_Contact__c = prfLang.get(opp.AccountId);
                lstOppUpdate.add(opp);
            }
        }
        if(!lstOppUpdate.isEmpty()){
            update lstOppUpdate;
        }
    }*/
    
    
    public static void generateRefferalCode(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        for(Account acc : accLst){
            if(String.isNotEmpty(acc.Django_ID__c) && String.isEmpty(acc.Referral_Code__c)){
                Blob requestBlob = Blob.valueOf(acc.Django_ID__c);
                Blob hash = Crypto.generateDigest('MD5', requestBlob);
                String requestSignature = EncodingUtil.convertToHex(hash);
                acc.Referral_Code__c = requestSignature.substring(0,5).tolowercase();
            }
        }
    }
    
    
    public static void validateFirstShrHolAsRelCont(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        
        List<Id> lstContact = new List<Id>();
        List<Id> lstAcc = new List<Id>();
        List<Account> lstConAcc = new List<Account>();
        for(Account acc : accLst){
            if(acc.First_Shareholder__c != null && mapOldAccnt.get(acc.ID).First_Shareholder__c != acc.First_Shareholder__c){
                lstContact.add(acc.First_Shareholder__c);
                lstAcc.add(acc.Id);
            }
        }
        
        if(!lstContact.isEmpty()){
            lstConAcc = [SELECT Id,Name, (SELECT ContactId FROM AccountContactRelations where ContactId =: lstContact[0]) FROM Account WHERE Id =: lstAcc[0]];
        }
        if(!lstConAcc.isEmpty()){
            for(Account ctAcc : lstConAcc){
                if(ctAcc.AccountContactRelations.isEmpty()){
                    for(Account acct : accLst){
                        acct.First_Shareholder__c.addError('Please associate it as the related Contact before adding it as a First Shareholder.');
                    }
                }
            }
        }
    }
    
    public static void validateFirstZGAsRelCont(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        
        List<Id> lstContact = new List<Id>();
        List<Id> lstAcc = new List<Id>();
        List<Account> lstConAcc = new List<Account>();
        for(Account acc : accLst){
            if(acc.First_ZG_Contact__c != null && mapOldAccnt.get(acc.ID).First_ZG_Contact__c != acc.First_ZG_Contact__c){
                lstContact.add(acc.First_ZG_Contact__c);
                lstAcc.add(acc.Id);
            }
        }
        
        if(!lstContact.isEmpty()){
            lstConAcc = [SELECT Id,Name, (SELECT ContactId FROM AccountContactRelations where ContactId =: lstContact[0]) FROM Account WHERE Id =: lstAcc[0]];
        }
        if(!lstConAcc.isEmpty()){
            for(Account ctAcc : lstConAcc){
                if(ctAcc.AccountContactRelations.isEmpty()){
                    for(Account acct : accLst){
                        acct.First_ZG_Contact__c.addError('Please associate it as the related Contact before adding it as a First ZG Contact.');
                    }
                }
            }
        }
    }
    
    /*public static void updateFieldsOnOpp(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        
        List<Id> lstAcc = new List<Id>();
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Account acc : accLst){
            if((mapOldAccnt.get(acc.ID).Winning_date__c != acc.Winning_date__c) || (mapOldAccnt.get(acc.ID).Go_Live_Date__c != acc.Go_Live_Date__c) || (mapOldAccnt.get(acc.ID).Company_Legal_Name__c != acc.Company_Legal_Name__c) || (mapOldAccnt.get(acc.ID).Name != acc.Name) || (mapOldAccnt.get(acc.ID).Industry != acc.Industry) || (mapOldAccnt.get(acc.ID).Nature_Purpose_of_business__c != acc.Nature_Purpose_of_business__c) || (mapOldAccnt.get(acc.ID).BillingStreet != acc.BillingStreet)  || (mapOldAccnt.get(acc.ID).BillingCity != acc.BillingCity)  || (mapOldAccnt.get(acc.ID).BillingPostalCode != acc.BillingPostalCode)  || (mapOldAccnt.get(acc.ID).BillingCountry != acc.BillingCountry)  || (mapOldAccnt.get(acc.ID).Link_to_sales_offer__c != acc.Link_to_sales_offer__c)  || (mapOldAccnt.get(acc.ID).Accounting_Start_Date__c != acc.Accounting_Start_Date__c) || (mapOldAccnt.get(acc.ID).Payroll_Start_Date__c != acc.Payroll_Start_Date__c) || (mapOldAccnt.get(acc.ID).AnnualRevenue != acc.AnnualRevenue) || (mapOldAccnt.get(acc.ID).Name_cash_register__c != acc.Name_cash_register__c) || (mapOldAccnt.get(acc.ID).CEP_Migration_necessary__c != acc.CEP_Migration_necessary__c) || (mapOldAccnt.get(acc.ID).NumberOfEmployees != acc.NumberOfEmployees)|| (mapOldAccnt.get(acc.ID).Problems_with_old_Advisors_Providers__c != acc.Problems_with_old_Advisors_Providers__c) || (mapOldAccnt.get(acc.ID).Sales_related_comments_for_ONB_and_CE__c != acc.Sales_related_comments_for_ONB_and_CE__c) || (mapOldAccnt.get(acc.ID).Industry_Type__c != acc.Industry_Type__c)){
                        lstAcc.add(acc.Id);
                    }
        }
        
        
        if(!lstAcc.isEmpty()){
            List<Opportunity> opList = [SELECT Id,Name,StageName,Go_Live_Date__c,CloseDate,Ac_Company_Legal_Name__c,Ac_Name__c,Ac_Industry__c,Ac_Nature_Purpose_of_business__c,Ac_ACC_BetriebsstaetteOrt__c,Ac_ACC_BetriebsstaetteLand__c,Ac_ACC_BetriebsstaettePostleitzahl__c,Ac_ACC_BetriebsstaetteStrase__c,Ac_Link_to_sales_offer__c,Ac_Accounting_Start_Date__c,Ac_Payroll_Start_Date__c,Ac_AnnualRevenue__c,Ac_Name_cash_register__c,Ac_CEP_Migration_necessary__c,Ac_NumberOfEmployees__c,A_Problems_with_old_Advisors_Providers__c,Ac_Sales_related_comments_for_ONB_and_CE__c,Ac_Industry_Type__c FROM Opportunity WHERE AccountId IN : lstAcc AND StageName != 'Closed Lost'];
            system.debug('####234' +opList);
            system.debug('####2345' +opList.size());
            if(!opList.isEmpty()){
                for(Account acc : accLst){
                    for(Opportunity op : opList){
                        system.debug('####2347888');
                        op.Ac_Company_Legal_Name__c = acc.Company_Legal_Name__c;
                        op.Ac_Name__c = acc.Name;
                        op.Ac_Industry__c = acc.Industry;
                        op.Ac_Nature_Purpose_of_business__c = acc.Nature_Purpose_of_business__c;
                        op.Ac_ACC_BetriebsstaetteStrase__c = acc.BillingStreet;
                        op.Ac_ACC_BetriebsstaetteOrt__c = acc.BillingCity;
                        op.Ac_ACC_BetriebsstaettePostleitzahl__c = acc.BillingPostalCode;
                        op.Ac_ACC_BetriebsstaetteLand__c = acc.BillingCountry;
                        op.Ac_Link_to_sales_offer__c = acc.Link_to_sales_offer__c;
                        op.Ac_Accounting_Start_Date__c = acc.Accounting_Start_Date__c;
                        op.Ac_Payroll_Start_Date__c = acc.Payroll_Start_Date__c;
                        op.Ac_AnnualRevenue__c = acc.AnnualRevenue;
                        op.Ac_Name_cash_register__c = acc.Name_cash_register__c;
                        op.Ac_CEP_Migration_necessary__c = acc.CEP_Migration_necessary__c;
                        op.Ac_NumberOfEmployees__c = acc.NumberOfEmployees;
                        op.A_Problems_with_old_Advisors_Providers__c = acc.Problems_with_old_Advisors_Providers__c;
                        op.Ac_Sales_related_comments_for_ONB_and_CE__c = acc.Sales_related_comments_for_ONB_and_CE__c;
                        op.Ac_Industry_Type__c = acc.Industry_Type__c;
                        op.Go_Live_Date__c = acc.Go_Live_Date__c;
                        //op.CloseDate = acc.Winning_date__c;
                        oppToUpdate.add(op);
                    }
                }
            }
            if(!oppToUpdate.isEmpty()){
                update oppToUpdate;
            }
        }
    }*/
    
    public static void sendAccountDetailsToDjango(List<Account> accLst, Map<Id,Account> mapOldAccnt){
        String billStrt;
        String billCity;
        String billPostal;
        String billCountry;
        String goLiveDate;
        String accStartDate;
        String parStartDate;
        
        for(Account acc : accLst){
            if((mapOldAccnt.get(acc.ID).Onboarding_Manager__c != acc.Onboarding_Manager__c) || (mapOldAccnt.get(acc.ID).Django_ID__c != acc.Django_ID__c) || (mapOldAccnt.get(acc.ID).Company_Legal_Name__c != acc.Company_Legal_Name__c) || (mapOldAccnt.get(acc.ID).Name != acc.Name) || (mapOldAccnt.get(acc.ID).Legal_Form__c != acc.Legal_Form__c) || (mapOldAccnt.get(acc.ID).Go_Live_Date__c != acc.Go_Live_Date__c) || (mapOldAccnt.get(acc.ID).Accounting_Start_Date__c != acc.Accounting_Start_Date__c) || (mapOldAccnt.get(acc.ID).Payroll_Start_Date__c != acc.Payroll_Start_Date__c) || (mapOldAccnt.get(acc.ID).First_ZG_Contact__c != acc.First_ZG_Contact__c) || (mapOldAccnt.get(acc.ID).Official_Email__c != acc.Official_Email__c) || (mapOldAccnt.get(acc.ID).Official_Phone__c != acc.Official_Phone__c) || (mapOldAccnt.get(acc.ID).billingstreet != acc.billingstreet) || (mapOldAccnt.get(acc.ID).billingcity != acc.billingcity) || (mapOldAccnt.get(acc.ID).billingPostalCode != acc.billingPostalCode) || (mapOldAccnt.get(acc.ID).BillingCountry != acc.BillingCountry)){
                
                billStrt = String.isNotEmpty(acc.billingstreet) ? acc.billingstreet : '';
                billCity = String.isNotEmpty(acc.billingcity) ? acc.billingcity : '';
                billPostal = String.isNotEmpty(acc.billingPostalCode) ? acc.billingPostalCode : '';
                billCountry = String.isNotEmpty(acc.BillingCountry) ? acc.BillingCountry : '';
                
                if(acc.Go_Live_Date__c == null){
                    goLiveDate = formatDates(Date.newInstance(2100, 12, 31));
                }else {
                    goLiveDate = formatDates(acc.Go_Live_Date__c);
                }
                
                if(acc.Accounting_Start_Date__c == null){
                    accStartDate = formatDates(Date.newInstance(2100, 12, 31));
                }else {
                    accStartDate = formatDates(acc.Accounting_Start_Date__c);
                }
                
                if(acc.Payroll_Start_Date__c == null){
                    parStartDate = formatDates(Date.newInstance(2100, 12, 31));
                }else {
                    parStartDate = formatDates(acc.Payroll_Start_Date__c);
                }
                
                //string billOrLegalAddress = String.isNotEmpty(acc.billingstreet) ? acc.billingstreet : '' + String.isNotEmpty(acc.billingcity) ? acc.billingcity : '' + String.isNotEmpty(acc.billingPostalCode) ? acc.billingPostalCode : ''+ String.isNotEmpty(acc.BillingCountry) ? acc.BillingCountry : '';
                //string billOrLegalAddress = billStrt+billCity+billPostal+billCountry;
                if((acc.Winning_date__c != null && acc.Name != null && acc.Company_Legal_Name__c != null && acc.Legal_Form__c != null && goLiveDate != null && accStartDate != null && parStartDate != null && acc.Salutation_of_first_ZG_Contact__c != null && acc.First_ZG_Contact__c != null && acc.Preferred_Language_of_first_ZG_Contact__c != null && acc.Official_Email__c != null && acc.Official_Phone__c != null && acc.billingstreet != null && acc.billingcity != null && acc.billingPostalCode != null && acc.BillingCountry != null && acc.Customer_Status__c != null && acc.Customer_Status__c != 'Closed Account') || (!Test.isRunningTest() && acc.Name != null && acc.Company_Legal_Name__c != null && acc.Legal_Form__c != null && goLiveDate != null && accStartDate != null && parStartDate != null && acc.Salutation_of_first_ZG_Contact__c != null && acc.First_ZG_Contact__c != null && acc.Preferred_Language_of_first_ZG_Contact__c != null && acc.Official_Email__c != null && acc.Official_Phone__c != null && acc.billingstreet != null && acc.billingcity != null && acc.billingPostalCode != null && acc.BillingCountry != null && acc.OBC1_Calendly_Link__c != null && acc.Onboarding_Manager__c != null && acc.Customer_Status__c != null && acc.Customer_Status__c != 'Closed Account')){
                    SendAccountDetailsToDjango.sendDetails(Id.valueOf(acc.Id),acc.Django_ID__c,acc.Name,acc.Company_Legal_Name__c,acc.Legal_Form__c,goLiveDate,accStartDate,parStartDate,acc.Salutation_of_first_ZG_Contact__c,acc.First_ZG_Contact_First_Name__c,acc.First_ZG_Contact_Last_Name__c,acc.Preferred_Language_of_first_ZG_Contact__c,acc.Official_Email__c,acc.Official_Phone__c,billStrt,billCity,billPostal,billCountry,acc.OBC1_Calendly_Link__c);
                }
            }
        }
    }
    
    public static String formatDates(Date inpDate){
         String dateFormatString = 'dd.MM.yyyy';
         Date d = inpDate;
         Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
         String dateString = dt.format(dateFormatString);
         return dateString;
    }
        
        
    
    /*public static void updateFirstShareDetails(List<Account> accLst, Map<Id,Account> mapOldAccnt) {
        Set<Id> lstContact = new Set<Id>();
        Set<Id> lstAcc = new Set<Id>();
        Map<Id,Id> mapofShrHolder = new Map<Id,Id>();
        List<Opportunity> lstOfOppToUpdate = new List<Opportunity>();
        for(Account acc : accLst){
            if(acc.First_Shareholder__c != null && mapOldAccnt.get(acc.ID).First_Shareholder__c != acc.First_Shareholder__c){
                lstContact.add(acc.First_Shareholder__c);
                lstAcc.add(acc.Id);
                mapofShrHolder.put(acc.Id,acc.First_Shareholder__c);
            }
        }
        if(!lstAcc.isEmpty()){
        List<Opportunity> lstOppLst = [SELECT Id,Name,AccountId,Ac_First_Shareholder__c FROM Opportunity WHERE AccountId IN : lstAcc];
        if(!lstOppLst.isEmpty()){
        for(Opportunity op : lstOppLst){
            op.Ac_First_Shareholder__c = mapofShrHolder.get(op.AccountId);
            lstOfOppToUpdate.add(op);
        }
        }
    }
        if(!lstOfOppToUpdate.isEmpty()){
            update lstOfOppToUpdate;
            
        }
    }*/
}