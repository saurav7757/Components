public class SendAccountDetailsToDjango {
    @future(callout=true)
    public static void sendDetails(String accId,String djangoId, String accName, String comLegalName, String lgForm, String goLiveDate, String accSrtDate, String paySrtrDate,String salZGName,String firstZGFrstName,String firstZGLastName,String peferrdLangZG, String offEmail, String offPhone, String billstr,String billcity,String billzip,String billcountry, String calendlyLink) {
        
        String PARJotformLink = System.Label.PAR_Jotform_Link + accId;
        String ACCJotformLink = System.Label.ACC_Jotform_Link + accId;
        JSONGenerator gen = JSON.createGenerator(true);    
        gen.writeStartObject(); 
        gen.writeStringField('Account Id', String.isNotEmpty(accName) ? accId : '');
        gen.writeStringField('Django Id', String.isNotEmpty(djangoId) ? djangoId : '');     
        gen.writeStringField('Display Name', String.isNotEmpty(accName) ? accName : '');
        gen.writeStringField('Company Legal Name', String.isNotEmpty(comLegalName) ? comLegalName : '');
        gen.writeStringField('Legal Form', String.isNotEmpty(lgForm) ? lgForm: '');
        gen.writeStringField('Go-Live Date', String.isNotEmpty(goLiveDate) ? goLiveDate: '');
        gen.writeStringField('Accounting Start Date', String.isNotEmpty(accSrtDate) ? accSrtDate: '');
        gen.writeStringField('Payroll Start Date', String.isNotEmpty(paySrtrDate) ? paySrtrDate: '');
        gen.writeStringField('Salutation of First ZG Contact', String.isNotEmpty(salZGName) ? salZGName: '');
        gen.writeStringField('First ZG Contact First Name', String.isNotEmpty(firstZGFrstName) ? firstZGFrstName: '');
        gen.writeStringField('First ZG Contact Last Name', String.isNotEmpty(firstZGLastName) ? firstZGLastName: '');
        gen.writeStringField('Preferred Language of First ZG Contact', String.isNotEmpty(peferrdLangZG) ? peferrdLangZG: '');
        gen.writeStringField('Email', String.isNotEmpty(offEmail) ? offEmail: '');
        gen.writeStringField('Phone', String.isNotEmpty(offPhone) ? offPhone: '');
        gen.writeStringField('Billing/Legal Street', String.isNotEmpty(billstr) ? billstr: '');
        gen.writeStringField('Billing/Legal City', String.isNotEmpty(billcity) ? billcity: '');
        gen.writeStringField('Billing/Legal ZipCode', String.isNotEmpty(billzip) ? billzip: '');
        gen.writeStringField('Billing/Legal Country', String.isNotEmpty(billcountry) ? billcountry: '');
        gen.writeStringField('Calendly Link', String.isNotEmpty(calendlyLink) ? calendlyLink: '');
        gen.writeStringField('Payroll JotForm Link', PARJotformLink);
        gen.writeStringField('Accounting JotForm Link', ACCJotformLink);
        gen.writeEndObject();    
        String jsonS = gen.getAsString();
        System.debug('jsonMaterials'+jsonS);
        
        // Sending the http body with JSON 
        try{
            String endpoint = WebServiceSettings__c.getValues('DjangoEndpoint').Endpoint_URL__c;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setTimeout(120000); // timeout in milliseconds
            req.setMethod('POST');
            req.setbody(jsonS);

            Http http = new Http();
            HTTPResponse response = http.send(req); 
            System.debug(response);
            System.debug(response.getStatus());
            System.debug(response.getBody()); 
            if (response.getStatusCode() != 200) {
                
                Request_Log__c rqLog = new Request_Log__c();
                rqLog.Name = accName;
                rqLog.Record_Id__c = accId;
                rqLog.HTTP_Request__c = jsonS;
                rqLog.Error_Message__c = response.getStatus();
                rqLog.Status__c = 'Error/Exception';
                insert rqLog;
            } else if (response.getStatusCode() == 200){
                Request_Log__c rqLog = new Request_Log__c();
                rqLog.Name = accName;
                rqLog.Record_Id__c = accId;
                rqLog.HTTP_Request__c = jsonS;
                rqLog.Error_Message__c = response.getStatus();
                rqLog.Status__c = 'Success';
                insert rqLog;
            }
        } catch (Exception ex){
                Request_Log__c rqLog = new Request_Log__c();
                rqLog.Name = accName;
                rqLog.Record_Id__c = accId;
                rqLog.HTTP_Request__c = jsonS;
                rqLog.Error_Message__c = ex.getMessage();
                rqLog.Status__c = 'Error/Exception';
                insert rqLog;
        }
    }
}