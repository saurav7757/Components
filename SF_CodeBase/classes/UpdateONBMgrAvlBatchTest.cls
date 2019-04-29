@isTest 
public class UpdateONBMgrAvlBatchTest 
{
    static testMethod void testMethod1() 
    {
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
        
            Account acc = new Account();
            acc.Name ='Test Account';
            acc.Go_Live_Date__c = Date.newInstance(2016, 12, 9);
            acc.Onboarding_Manager__c = u.Id;
        
            insert acc;
            
            Onboarding_Manager_Availability__c onb = new Onboarding_Manager_Availability__c();
            onb.Month__c = Date.newInstance(2016, 12, 9);
            onb.Related_Onboarding_Manager__c = u.Id;
            onb.Total_Capacity__c = 10;
            onb.Remaining_Capacity__c = 9;
            insert onb;
        
        Test.startTest();

            UpdateONBMgrAvlBatch obj = new UpdateONBMgrAvlBatch();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}