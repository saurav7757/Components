@isTest
public class AddUsersToChatterGroupsBatchTestClass{
    static testMethod void addUsersToChatterGroupsBatchTest() {
        UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'Payroll CCAa');
        insert r;
        
        User u1 = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Onboarding'].Id,
             LastName = 'last1',
             Email = 'puser1000@amamama.com',
             Username = 'puser1000@amamama.com' + System.currentTimeMillis(),
             CompanyName = 'TEST1',
             UserRoleId = r.Id,
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
        );
        insert u1;
        
        User u3 = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
             LastName = 'last3',
             Email = 'puser13000@amamama.com',
             Username = 'puser13000@amamama.com' + System.currentTimeMillis(),
             CompanyName = 'TEST13',
             UserRoleId = r.Id,
             Title = 'title',
             Alias = 'alias',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
        );
        insert u3;
        
         UserRole r1 = new UserRole(DeveloperName = 'MyCustomRole1', Name = 'Accounting CCAa');
         insert r1;
            
         System.runAs(u1) {   
         CollaborationGroup g = new CollaborationGroup(Name='Payroll CCAa', CollaborationType='Public');
         insert g;
         
         CollaborationGroup g1 = new CollaborationGroup(Name='Accounting CCAa', CollaborationType='Public');
         insert g1;
       }
        
        
        
         //try{
        //User us = [select id,name,UserRoleId from user where Id =: u1.Id];
        //AddUsersToChatterGroupsBatch obj = new AddUsersToChatterGroupsBatch();
        //DataBase.executeBatch(obj, 1); 
        Test.StartTest();
          AddUsersToChatterGroupsBatch obj = new AddUsersToChatterGroupsBatch();
           DataBase.executeBatch(obj, 1); 
           //Id batchJobId = Database.executeBatch(new AddUsersToChatterGroupsBatch(), 2);
           //System.abortJob(batchJobId);
        Test.StopTest();
      // }catch (System.UnexpectedException theException){ // this exeption will not be catch because it is probably thown in a separate transaction
          //  System.assertEquals('No more than one executeBatch can be called from within a testmethod. Please make sure the iterable returned from ' +
          //      'your start method matches the batch size, resulting in one executeBatch invocation.', theException.getMessage());
 
       // }
    }

}