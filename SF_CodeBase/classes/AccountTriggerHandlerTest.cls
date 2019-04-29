@IsTest
private class AccountTriggerHandlerTest
{
    private static testMethod void AccountTriggerHandlerTestMethod() 
    {
        List<Account> lstAcc = new List<Account>();
        Map<Id,Account> mapOldAccnt = new Map<Id,Account>();
        List<Account> lstAcc1 = new List<Account>();
        Map<Id,Account> mapOldAccnt1 = new Map<Id,Account>();
        Trigger_Settings__c cs1 = new Trigger_Settings__c();
        cs1.Name='AccountTrigger';
        cs1.Is_Active__c = true;
        insert cs1;
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        testAccount.Company_Legal_Name__c='Test Account' ;
        testAccount.BillingStreet = 'test';
        testAccount.BillingCity= 'test';
        testAccount.BillingState = 'test';
        testAccount.BillingPostalCode = '12345';
        testAccount.BillingCountry = 'test';
        insert testAccount;
        
        Account testAccount1 = new Account();
        testAccount1.Name='Test Account1' ;
        testAccount1.Django_ID__c='12345' ;
        testAccount1.Company_Legal_Name__c='Test Account1' ;
        testAccount1.BillingStreet = 'test';
        testAccount1.BillingCity= 'test';
        testAccount1.BillingState = 'test';
        testAccount1.BillingPostalCode = '12345';
        testAccount1.BillingCountry = 'test';
        insert testAccount1;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.Language__c = 'English';
        cont.Accountid= testAccount.id;
        insert cont;
        
        Contact cont1 = new Contact();
        cont1.FirstName='Test';
        cont1.LastName='Test';
        cont1.Language__c = 'English';
        cont1.Accountid= testAccount1.id;
        insert cont1;
        
        AccountContactRelation ac = new AccountContactRelation();
        ac.AccountId = testAccount1.Id;
        ac.ContactId = cont.Id;
        insert ac;
        
        AccountContactRelation ac1 = new AccountContactRelation();
        ac1.AccountId = testAccount.Id;
        ac1.ContactId = cont1.Id;
        insert ac1;
        
        Account acc1 = [SELECT Id,First_ZG_Contact__c,First_Shareholder__c,Django_ID__c FROM Account WHERE Id =: testAccount.id];
        acc1.First_ZG_Contact__c = cont.id;
        acc1.First_Shareholder__c = cont1.id;
        update acc1;
        
        Account acc2 = [SELECT Id,First_ZG_Contact__c,First_Shareholder__c,Django_ID__c,Referral_Code__c FROM Account WHERE Id =: testAccount1.id];
        acc2.First_ZG_Contact__c = null;
        acc2.First_Shareholder__c = null;
        acc2.Django_ID__c = '768987';
        update acc2;
        
        lstAcc.add(acc1);
        mapOldAccnt.put(acc1.Id,acc1);
        lstAcc1.add(acc2);
        mapOldAccnt1.put(acc2.Id,acc2);
 
        
        Test.startTest();
        //AccountTriggerHandler.updateFirstShareDetailsOnOpp(lstAcc, mapOldAccnt);
        //AccountTriggerHandler.updateFirstShareDetailsOnOpp(lstAcc, mapOldAccnt);
        AccountTriggerHandler.generateRefferalCode(lstAcc1, mapOldAccnt1); 
        AccountTriggerHandler.formatDates(System.Today());
        Test.stopTest();
        
    }
}