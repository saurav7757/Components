@IsTest
private class UpdateLeadsRecordForAssesmentTest
{
    private static testMethod void updateRecordTest() 
    {

        // create a Lead
        Lead lead=new Lead(LastName='Doe',FirstName='John',Company='Test',Status='Converted');
        insert lead;                

        lead=  [SELECT Id,Status, NumberOfEmployees ,FirstName,LastName,Company,LeadSource FROM Lead WHERE Id = :lead.Id];
        UpdateLeadsRecordForAssesment.updateRecord (lead,lead.Id,21,'Test','Test');
        UpdateLeadsRecordForAssesment.getselectOptions (Lead,'LeadSource');
        UpdateLeadsRecordForAssesment.getLeadDetails (lead.Id);
        System.assertEquals('Converted', lead.Status);

        update  lead;
    }
}