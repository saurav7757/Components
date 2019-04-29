@isTest 
public class SendFailedDjangoRequestsTest 
{
    static testMethod void calloutTestMethod() 
    {
        
            Request_Log__c rqs = new Request_Log__c();
            rqs.Name ='Test Name';
            rqs.HTTP_Request__c = 'Test Name';
            rqs.Record_Id__c ='Test Name';
            rqs.Error_Message__c ='Test Name';
        
            insert rqs;
        
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new HTTPMockCallout());
            SendFailedDjangoRequests obj = new SendFailedDjangoRequests();
            DataBase.executeBatch(obj,1); 
            
        Test.stopTest();
    }
}