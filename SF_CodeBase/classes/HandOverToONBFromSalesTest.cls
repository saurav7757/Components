@IsTest
private class HandOverToONBFromSalesTest
{
    private static testMethod void updateHandOverToONBFromSalesRecordTest() 
    {
        Trigger_Settings__c cs = new Trigger_Settings__c();
        cs.Name='OpportunityTrigger';
        cs.Is_Active__c = true;
        insert cs;
        
        
        ZG_Customer_Number__c cs3 = new ZG_Customer_Number__c();
        cs3.Name='Customer_Number';
        cs3.Current_Number__c = 12;
        insert cs3;
        
        Trigger_Settings__c cs1 = new Trigger_Settings__c();
        cs1.Name='AccountTrigger';
        cs1.Is_Active__c = true;
        insert cs1;
        
        User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Onboarding'].Id,
             LastName = 'last',
             Email = 'puser000@amamama.com',
             Username = 'puser000@amamama.com' + System.currentTimeMillis(),
             CompanyName = 'TEST',
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
        );
        insert u;
        
        User u1 = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Onboarding'].Id,
             LastName = 'last1',
             Email = 'puser0001@amamama.com',
             Username = 'puser0001@amamama.com' + System.currentTimeMillis(),
             CompanyName = 'TEST1',
             Title = 'title1',
             Alias = 'alias1',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
        );
        insert u1;
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        testAccount.Company_Legal_Name__c='Test Account' ;
        testAccount.BillingStreet = 'test';
        testAccount.BillingCity= 'test';
        testAccount.BillingState = 'test';
        testAccount.BillingPostalCode = '12345';
        testAccount.BillingCountry = 'test';
        insert testAccount;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Language__c = 'English';
        cont.Accountid= testAccount.id;
        insert cont;
        
        Contact cont1 = new Contact();
        cont1.FirstName='Test1';
        cont1.LastName='Test1';
        cont1.Language__c = 'English';
        cont1.Accountid= testAccount.id;
        insert cont1;
        
        Account acc1 = [SELECT Id,First_ZG_Contact__c FROM Account WHERE Id =: testAccount.id];
        acc1.First_ZG_Contact__c = cont.id;
        acc1.Go_Live_Date__c = Date.newInstance(2019, 1, 1);
        update acc1;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = testAccount.id;
        opp.Amount = 20000;
        opp.CloseDate = date.today();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Accepted by AE';
        insert opp;
        
        Onboarding_Manager_Availability__c obm = new Onboarding_Manager_Availability__c();
        obm.Language__c = 'English';
        obm.Month__c = Date.newInstance(2019, 1, 1);
        obm.Related_Onboarding_Manager__c = u.Id;
        obm.Total_Capacity__c = 5;
        obm.Remaining_Capacity__c = 5;
        insert obm;
        
        //Test.StartTest();
            List<Id> opList = new List<Id>(); 
            Opportunity op = [SELECT Id,StageName,Go_Live_Date__c,Ready_to_Handover__c,Demo_completed__c FROM Opportunity WHERE Id =:opp.Id];
            op.Demo_completed__c = 'Yes';
            op.StageName = 'Closed Won';
            op.Go_Live_Date__c = Date.newInstance(2019, 1, 1);
            op.Ready_to_Handover__c = true;
            op.First_ZG_Contact__c = cont.Id;
            op.Ac_First_Shareholder__c = cont1.Id;
            update op;
            opList.add(op.Id);
            Account acc = [SELECT Id,Onboarding_Manager__c FROM Account WHERE Id =: testAccount.Id];
            acc.Onboarding_Manager__c = u1.Id;
            update acc;
           //AssignONBManager.assignOnboardingManager(opList); 
        //Test.StopTest();
        
        Test.StartTest();
        HandOverToONBFromSales.getselectOptions (op,'StageName');
        HandOverToONBFromSales.getZGDetails (String.valueOf(cont.Id));
        HandOverToONBFromSales.getFilledZGDetails (String.valueOf(op.Id));
        HandOverToONBFromSales.getFillZGDetails (String.valueOf(op.Id));
        HandOverToONBFromSales.getShrHoldDetails (String.valueOf(cont.Id));
        HandOverToONBFromSales.getFilledShrHolDetails (String.valueOf(op.Id));
        //HandOverToONBFromSales.getFillShrHolDetails (String.valueOf(op.Id));
        HandOverToONBFromSales.getOppFilDetails (String.valueOf(op.Id));
        HandOverToONBFromSales.updateRecordWithoutHandover (op, acc1,String.valueOf(acc1.Id),String.valueOf(op.Id), String.valueOf(cont.Id), String.valueOf(cont.Id),cont,cont1,1);
        HandOverToONBFromSales.updateRecord (op, acc1,String.valueOf(acc1.Id),String.valueOf(op.Id), String.valueOf(cont.Id), String.valueOf(cont.Id),cont,cont1,1,null);
        HandOverToONBFromSales.assignOnboardingManager (String.valueOf(op.Id), String.valueOf(cont.Id));
        //HandOverToONBFromSales.getLeadDetails (lead.Id);
        //System.assertEquals('Converted', lead.Status);
        Test.StopTest();
        //update  lead;
    }
}