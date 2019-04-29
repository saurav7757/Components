@isTest 
public class FeedItemTriggerHandlerTestClass {
     static testMethod void changeFeedItemTypeTest() {
         Trigger_Settings__c cs = new Trigger_Settings__c();
         cs.Name='FeedItemTrigger';
         cs.Is_Active__c = true;
         insert cs;
         
         Task t = new Task();
         t.Subject='Donni';
         t.Status='New';
         t.Priority='Normal';
         //t.CallType='Outbound';
         insert t;
         
         
         FeedItem fd = new FeedItem();
         fd.ParentId = t.Id;
         //fd.Body = 'testing';
         fd.Type = 'CallLogPost';
         insert fd;
         fd.isRichText = true;
         update fd;
          
     }
}