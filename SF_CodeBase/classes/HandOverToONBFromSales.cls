/************************************************************
 
 Name: HandOverToONBFromSales
 Type: Apex Class  
 Purpose: Apex Class  for  lightning component 
          HandOverToONBComponent.cmp
 ***********************************************************/
public without sharing class HandOverToONBFromSales{

     
    
    @AuraEnabled
    public static List <String> getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
         
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
         
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
         
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
        fieldMap.get(fld).getDescribe().getPickListValues();
         
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
           allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    
    @AuraEnabled
    public static List <Contact> getZGDetails(string contID) {
        List<Contact> conResult = [SELECT Id,Salutation,FirstName,LastName,Email,Phone,Title,Tone_of_address__c,Language__c FROM Contact WHERE Id =: contID];
        return conResult;
    }
    
    @AuraEnabled
    public static List <Opportunity> getFilledZGDetails(string optyID) {
        List<Opportunity> oppResult = [SELECT Id,Account.First_ZG_Contact__c,Account.First_ZG_Contact__r.Salutation,Account.First_ZG_Contact__r.FirstName,Account.First_ZG_Contact__r.LastName,Account.First_ZG_Contact__r.Email,Account.First_ZG_Contact__r.Phone,Account.First_ZG_Contact__r.Title,Account.First_ZG_Contact__r.Tone_of_address__c,Account.First_ZG_Contact__r.Language__c FROM Opportunity WHERE Id =: optyID];
        if(oppResult[0].Account.First_ZG_Contact__c != null) {
            return oppResult;
        } else {
            return null;
        }
    }
    
    @AuraEnabled
    public static SObject getFillZGDetails(string optyID) {
        List<Opportunity> oppResult = [SELECT Id,Account.First_ZG_Contact__c FROM Opportunity WHERE Id =: optyID];
        if(!oppResult.isEmpty() && oppResult[0].Account.First_ZG_Contact__c != null){
            Id contId = oppResult[0].Account.First_ZG_Contact__c;
            Schema.SObjectType sobjectType = contId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();

            SObject record = Database.query('Select Id, Name From ' + sobjectName + ' Where Id = :contId');
        
            return record;
        }else 
            return null;
        
    }
    
    @AuraEnabled
    public static SObject getParentAccountDetails(string opID) {
        List<Opportunity> oppResult = [SELECT Id,Account.ParentId FROM Opportunity WHERE Id =: opID];
        if(!oppResult.isEmpty() && oppResult[0].Account.ParentId != null){
            Id accId = oppResult[0].Account.ParentId;
            Schema.SObjectType sobjectType = accId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();

            SObject record = Database.query('Select Id, Name From ' + sobjectName + ' Where Id = :accId');
        
            return record;
        }else 
            return null;
        
    }
    
    @AuraEnabled
    public static List <Contact> getShrHoldDetails(string contshrID) {
        List<Contact> conResultHolder = [SELECT Id,Salutation,FirstName,LastName,Email,Phone,Title,Tone_of_address__c,Language__c FROM Contact WHERE Id =: contshrID];
        return conResultHolder;
    }
    
    @AuraEnabled
    public static List <Opportunity> getFilledShrHolDetails(string opptyID) {
        List<Opportunity> oppResult = [SELECT Id,Account.First_Shareholder__c,Account.First_Shareholder__r.Salutation,Account.First_Shareholder__r.FirstName,Account.First_Shareholder__r.LastName,Account.First_Shareholder__r.Email,Account.First_Shareholder__r.Phone,Account.First_Shareholder__r.Title,Account.First_Shareholder__r.Tone_of_address__c,Account.First_Shareholder__r.Language__c FROM Opportunity WHERE Id =: opptyID];
        if(oppResult[0].Account.First_Shareholder__c != null) {
            return oppResult;
        } else {
            return null;
        }
    }
    
    @AuraEnabled
    public static SObject getFillShrHolDetails(string opptyID) {
        List<Opportunity> oppResult = [SELECT Id,Account.First_Shareholder__c FROM Opportunity WHERE Id =: opptyID];
        if(!oppResult.isEmpty() && oppResult[0].Account.First_Shareholder__c != null){
            Id contId = oppResult[0].Account.First_Shareholder__c;
            Schema.SObjectType sobjectType = contId.getSObjectType();
            String sobjectName = sobjectType.getDescribe().getName();

            SObject record = Database.query('Select Id, Name From ' + sobjectName + ' Where Id = :contId');
        
            return record;
        } else 
            return null;
    }
    
    @AuraEnabled
    public static List<Opportunity> getOppFilDetails(String opId) {
        List<Opportunity> oppResult = [SELECT Id,Name,AccountId,Account.Go_Live_Date__c,Account.Company_Legal_Name__c,Account.Name,Account.Industry,Account.Industry_Type__c,Account.BillingStreet,Account.BillingCity,Account.BillingPostalCode,Account.BillingCountry,Account.Nature_Purpose_of_business__c,Account.Link_to_sales_offer__c,Account.Accounting_Start_Date__c,Account.AnnualRevenue,Account.NumberOfEmployees,Account.Payroll_Start_Date__c,Account.Name_cash_register__c,Account.CEP_Migration_necessary__c,Account.VAT_declaration_cadence__c,Account.VAT_declaration_extension_DFV__c,Account.Sales_related_comments_for_ONB_and_CE__c,Account.Problems_with_old_Advisors_Providers__c,Salutation_of_first_ZG_Contact__c,First_name_of_first_ZG_Contact__c,Surname_of_first_ZG_Contact__c,Email_of_first_ZG_Contact__c,Phone_of_first_ZG_Contact__c,Preferred_Language_of_first_ZG_Contact__c,Tone_of_address_for_first_ZG_Contact__c,Function_in_company_of_first_ZG_Contact__c,Ac_Salutation__c,Ac_First_name_ZG_1st_Contact_Person__c,Ac_Surname_ZG_1st_Contact_Person__c,Ac_Email_of_1st_ZG_Contact__c,Ac_Tel_of_1st_ZG_Contact__c,
        Ac_Preferred_Language_of_1st_ZG_Contact__c,Ac_Tone_of_address__c,Ac_Function_in_company_of_1st_ZG_Contact__c,Account.Is_ZG_First_Contact_and_Shareholder_same__c,MRR_Zeitgold__c,MRR_Tax_Advisor__c,Special_Initial_MRR_w_o_Tax_Advisor_F__c,
        Special_Initial_MRR_Valid_for_how_many_m__c,Total_monthly_Tax_advisor_fee__c,Total_annual_tax_advisor_fee__c,ARR_Tax_Advisor_Year_End_Statement__c,Special_offer_Other_if_applicable__c,Special_offer_PIO_if_applicable__c FROM Opportunity WHERE Id =: opId];
        return oppResult;
    }
    
     @AuraEnabled
    public static void updateRecordWithoutHandover(Opportunity oppRecDetails, Account accDet, String accId, String opRecId, String firstZgCont, String firstShareHol, Contact conFrtZG, Contact conFrtShrHol, Integer noOfEmp){
        
        try{
            
            if(oppRecDetails != null && String.isNotEmpty(opRecId)){
                oppRecDetails.Id = opRecId;
                //oppRecDetails.First_ZG_Contact__c = firstZgCont;
                //oppRecDetails.Ac_First_Shareholder__c = firstShareHol;
                oppRecDetails.StageName = 'Closed Won';
                oppRecDetails.Ready_to_Handover__c = true;
                update oppRecDetails;
            }
            system.debug('Account list vals11 :' + accDet);
            system.debug('Account list vals 12:' + accId);
            if(accDet != null && String.isNotEmpty(accId) && noOfEmp != null  && String.isNotEmpty(firstZgCont) && String.isNotEmpty(firstShareHol)){
                accDet.Id = accId;
                accDet.First_ZG_Contact__c = firstZgCont;
                accDet.First_Shareholder__c = firstShareHol;
                accDet.NumberOfEmployees = Integer.valueOf(noOfEmp);
                system.debug('Account list vals :' + accDet);
                update accDet;
            }
            if(conFrtZG != null && String.isNotEmpty(firstZgCont)){
                conFrtZG.Id = firstZgCont;
                system.debug('con1 list vals :' + conFrtZG);
                update conFrtZG;
            }
            if(conFrtShrHol != null && String.isNotEmpty(firstShareHol)){
                conFrtShrHol.Id = firstShareHol;
                system.debug('con2 list vals :' + conFrtShrHol);
                update conFrtShrHol;
            }
            
        } catch (Exception ex){
            system.debug('Exception here -----> ' + ex.getMessage());
            //throw new AuraHandledException(ex.getMessage());
        }
        
    }
    
     @AuraEnabled
    public static String updateRecord (Opportunity oppRecDetails, Account accDet, String accId, String opRecId, String firstZgCont, String firstShareHol,Contact conFrtZG, Contact conFrtShrHol, Integer noOfEmp, String parentAccId){
        system.debug('##########0000' + firstZgCont);
        system.debug('##########0000123' + firstShareHol);
        String onbManagrName;
        List<Account> lstParentAcc = new List<Account>();
        Database.SaveResult srList;
        Database.SaveResult srListAcc;
        Database.SaveResult srListConZG;
        Database.SaveResult srListConShrHol;
        try{
            
            if(oppRecDetails != null && String.isNotEmpty(opRecId)){
                system.debug('##########000012345' + oppRecDetails);
                oppRecDetails.Id = opRecId;
                //oppRecDetails.First_ZG_Contact__c = firstZgCont;
                //oppRecDetails.Ac_First_Shareholder__c = firstShareHol;
                oppRecDetails.StageName = 'Closed Won';
                oppRecDetails.Ready_to_Handover__c = true;
                srList = Database.update(oppRecDetails, false);
                
            }
            
            if(accDet != null && String.isNotEmpty(accId) && noOfEmp != null  && String.isNotEmpty(firstZgCont) && String.isNotEmpty(firstShareHol)){
                accDet.Id = accId;
                accDet.First_ZG_Contact__c = firstZgCont;
                accDet.First_Shareholder__c = firstShareHol;
                accDet.NumberOfEmployees = Integer.valueOf(noOfEmp);
                if(String.isNotEmpty(parentAccId)){
                    accDet.ParentId = parentAccId;
                    lstParentAcc = [SELECT Id,Name,Onboarding_Manager__c,Onboarding_Manager__r.Name FROM Account WHERE Id =: parentAccId];
                    if(lstParentAcc[0].Onboarding_Manager__c != null){
                        User usr = [SELECT Id,Name,isActive,Profile.Name FROM User WHERE Id =: lstParentAcc[0].Onboarding_Manager__c];
                        if(usr.isActive == true && usr.Profile.Name == 'Onboarding'){
                            accDet.Onboarding_Manager__c = lstParentAcc[0].Onboarding_Manager__c;
                            onbManagrName = lstParentAcc[0].Onboarding_Manager__r.Name;
                            system.debug('ONB Name--->' + onbManagrName);
                        }
                    }
                }
                system.debug('Account list vals :' + accDet);
                srListAcc = Database.update(accDet, false);
                //update accDet;
            }
            if(conFrtZG != null && String.isNotEmpty(firstZgCont)){
                conFrtZG.Id = firstZgCont;
                system.debug('con1 list vals :' + conFrtZG);
                srListConZG = Database.update(conFrtZG, false);
                //update conFrtZG;
            }
            if(conFrtShrHol != null && String.isNotEmpty(firstShareHol)){
                conFrtShrHol.Id = firstShareHol;
                system.debug('con2 list vals :' + conFrtShrHol);
                srListConShrHol = Database.update(conFrtShrHol, false);
                //update conFrtShrHol;
            }
            
            if(srList.isSuccess() && srListAcc.isSuccess() && srListConZG.isSuccess() && srListConShrHol.isSuccess() && String.isEmpty(onbManagrName)){
                    system.debug('##########000012345678' + oppRecDetails);
                    onbManagrName = HandOverToONBFromSales.assignOnboardingManager(opRecId, firstZgCont);
                }
            
        } catch (Exception ex){
            onbManagrName = null;
            system.debug('Exception here -----> ' + ex.getMessage());
            //throw new AuraHandledException(ex.getMessage());
        }
        return onbManagrName;
        
    }
    
    @AuraEnabled
     public static String assignOnboardingManager(String oppListId, String frstZGContId){
        String ONBMgrName;
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
        List<Onboarding_Manager_Availability__c> onbmgravailability = new List<Onboarding_Manager_Availability__c>();
        
        for(Opportunity opp : [SELECT Id,AccountId,Ready_to_Handover__c,StageName FROM Opportunity WHERE Id =: oppListId]){
        system.debug('##########234' + opp);
            //if(opp.Ready_to_Handover__c == true && opp.StageName == 'Closed Won'){
                accountIDS.add(opp.AccountId);
                //liveMonth = opp.Go_Live_Date__c.month();
                //liveYear = opp.Go_Live_Date__c.year();
            //}
        }
        if(!accountIDS.isEmpty()){
            //List<Contact> lstCont = [Select Id, Name, Language__c From Contact where AccountId IN: accountIDS];
            List<Account> lstAcc = [SELECT Id, Onboarding_Manager__c,First_ZG_Contact__c,Go_Live_Date__c FROM Account WHERE Id IN: accountIDS];
            for(Account acc : lstAcc){
                if(acc.First_ZG_Contact__c != null){
                    firstShrhlId.add(acc.First_ZG_Contact__c);
                    liveMonth = acc.Go_Live_Date__c.month();
                    liveYear = acc.Go_Live_Date__c.year();
                }
            }
            if(firstShrhlId.isEmpty()){
                firstShrhlId.add(Id.valueOf(frstZGContId));
            }
            if(!firstShrhlId.isEmpty()){
                List<Contact> lstCont = [Select Id, Name, Language__c From Contact where Id IN: firstShrhlId];
                if(lstCont[0].Language__c != null || lstCont[0].Language__c != ''){
                    preferredLang = lstCont[0].Language__c;
                }
            }
            if(String.isNotEmpty(preferredLang)){
                onbmgravailability = [SELECT Id,Language__c, Month__c, Related_Onboarding_Manager__c,Remaining_Capacity__c,Total_Capacity__c 
                                                                            FROM Onboarding_Manager_Availability__c WHERE Language__c includes(:preferredLang)];
            }
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
                                
                                
                            }
                        }
                    }
                }
                //if(relativeCapLstToCalc.isEmpty()){
                    //for(Opportunity opp : oppList){
                        //opp.addError('There is no Onboarding Manager available with given go-live date and/or with preferred language.');
                    //}
                //}
                
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
            
            List<Account> accLstOnbName = [SELECT Id,Django_ID__c,Salutation_of_first_ZG_Contact__c,Preferred_Language_of_first_ZG_Contact__c,Customer_Status__c,First_Shareholder__c,First_ZG_Contact__c,Onboarding_Manager_Name__c,Name,Company_Legal_Name__c,Legal_Form__c,Go_Live_Date__c,Accounting_Start_Date__c,Payroll_Start_Date__c,Official_Email__c,Official_Phone__c,billingstreet,billingcity,billingstate,billingPostalCode,billingCountry,OBC1_Calendly_Link__c FROM Account WHERE Id IN: accountIDS];
            ONBMgrName = accLstOnbName[0].Onboarding_Manager_Name__c;
            if(String.isNotEmpty(ONBMgrName) && accLstOnbName[0].First_ZG_Contact__c != null && accLstOnbName[0].First_Shareholder__c != null) {
                //String billStrt;
                //String billCity;
                //String billPostal;
                //String billCountry;
                //string billOrLegalAddress = accLstOnbName[0].billingstreet+ accLstOnbName[0].billingcity + accLstOnbName[0].billingstate + accLstOnbName[0].billingPostalCode+ accLstOnbName[0].BillingCountry;
                //billStrt = String.isNotEmpty(accLstOnbName[0].billingstreet) ? accLstOnbName[0].billingstreet : '';
                //billCity = String.isNotEmpty(accLstOnbName[0].billingcity) ? accLstOnbName[0].billingcity : '';
                //billPostal = String.isNotEmpty(accLstOnbName[0].billingPostalCode) ? accLstOnbName[0].billingPostalCode : '';
                //billCountry = String.isNotEmpty(accLstOnbName[0].BillingCountry) ? accLstOnbName[0].BillingCountry : '';
                
                
                //if(!Test.isRunningTest() && accLstOnbName[0].Customer_Status__c != null && accLstOnbName[0].Customer_Status__c != 'Closed Account'){
                    //SendAccountDetailsToDjango.sendDetails(Id.valueOf(accLstOnbName[0].Id),accLstOnbName[0].Django_ID__c ,accLstOnbName[0].Name, accLstOnbName[0].Company_Legal_Name__c,accLstOnbName[0].Legal_Form__c, formatDates(accLstOnbName[0].Go_Live_Date__c), formatDates(accLstOnbName[0].Accounting_Start_Date__c),formatDates(accLstOnbName[0].Payroll_Start_Date__c),accLstOnbName[0].Salutation_of_first_ZG_Contact__c,accLstOnbName[0].First_ZG_Contact_Name__c,accLstOnbName[0].Preferred_Language_of_first_ZG_Contact__c,accLstOnbName[0].Official_Email__c,accLstOnbName[0].Official_Phone__c,billStrt,billCity,billPostal,billCountry,accLstOnbName[0].OBC1_Calendly_Link__c);
                //}
                return ONBMgrName;
            }
        }
        return null;
    }
        
        public static String formatDates(Date inpDate){
            String dateFormatString = 'dd.MM.yyyy';
            Date d = inpDate;
            Datetime dt = Datetime.newInstance(d.year(), d.month(),d.day());
            String dateString = dt.format(dateFormatString);
            return dateString;
        }
}