global class SendFailedDjangoRequests implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
    
    public Set<Id> successRecId = new Set<Id>();
   global Database.QueryLocator start(Database.BatchableContext BC){
      String query = 'SELECT Id,HTTP_Request__c from Request_Log__c';
        return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Request_Log__c> scope){
       
       String endpoint;
       if(Test.isRunningTest()){
            endpoint = 'www.dummy.com';
        } else {
            endpoint = WebServiceSettings__c.getValues('DjangoEndpoint').Endpoint_URL__c;
        }
       
       for(Request_Log__c rq : scope){
        
           try{
                HttpRequest req = new HttpRequest();
                req.setEndpoint(endpoint);
                req.setMethod('POST');
                req.setbody(rq.HTTP_Request__c);

                Http http = new Http();
                HTTPResponse response = http.send(req); 
                System.debug(response);
                System.debug(response.getStatus());
                System.debug(response.getBody()); 
                if (response.getStatusCode() == 200) {
                    successRecId.add(rq.Id);
                }
            } catch (Exception ex){
               
            }
        }
}
   global void finish(Database.BatchableContext BC){
        if(!successRecId.isEmpty()){
            List<Request_Log__c> lstRecs = [SELECT Id from Request_Log__c WHERE Id IN : successRecId];
            if(!lstRecs.isEmpty()){
                delete lstRecs;
            }
        }
   }
}