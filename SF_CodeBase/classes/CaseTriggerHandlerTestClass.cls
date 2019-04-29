@isTest 
public class CaseTriggerHandlerTestClass {
     static testMethod void assignOnboardingManagerTest() {
         Trigger_Settings__c cs = new Trigger_Settings__c();
         cs.Name='CaseTrigger';
         cs.Is_Active__c = true;
         insert cs;
         
         UserRole r;
         User u1;
         User u = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
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
        
        System.runAs(u){
        r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'Payroll CCAa');
        insert r;
       
        u1 = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'Zeitgold Service Cloud User'].Id,
             LastName = 'last1',
             Email = 'puser1000@amamama.com',
             Username = 'puser1000@amamama.com' + System.currentTimeMillis(),
             CompanyName = 'TEST1',
             UserRoleId = r.Id,
             Title = 'title1',
             Alias = 'alias1',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
        );
        insert u1;
          }
         Case c = new Case();

         c.Status = 'New';
         c.Origin = 'Phone';
         c.OwnerId = u.Id;
        insert c;
         c.OwnerId = u1.Id;
         update c;
         UpdateCaseOwnership.takeOwnershipnCase(c.Id,'');
         UpdateCaseOwnership.takeOwnershipnCase(c.Id, u.Id);
     }
}