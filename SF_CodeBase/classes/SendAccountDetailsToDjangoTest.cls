@isTest
private class SendAccountDetailsToDjangoTest {
    testMethod static void testCallout() {
        // Set mock callout class 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HTTPMockCallout());
        // from the class that implements HttpCalloutMock. 
        SendAccountDetailsToDjango.sendDetails('Test1','Test2','Test3','Test4','Test5','Test6','Test7','Test8','Test9','Test10','Test11','Test12','Test13','Test14','Test15','Test16','Test17','Test18','Test19');
        
        // Verify response received contains fake values
        //String contentType = res.getHeader('Content-Type');
        //System.assert(contentType == 'application/json');
        //System.assertEquals(200, res.getStatusCode());
        Test.stopTest();
    }
}