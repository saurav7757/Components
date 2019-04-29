/************************************************************
 
 Name: UpdateLeadsRecordForAssesment
 Type: Apex Class  
 Purpose: Apex Class  for  lightning component 
          LeadAssesmentCallStatusUpdate.cmp
 ***********************************************************/
public without sharing class UpdateLeadsRecordForAssesment {

    @AuraEnabled
    public static void updateRecord (Lead leadRecDetails, String leadRecId, Integer noEmployee, String ldNotes, String ldTitle){
        
        try{
            System.debug('CreateCandidateRecord::createRecord::candidate'+leadRecDetails);
            System.debug('CreateCandidateRecord::createRecord::candidate#####'+leadRecId);
            
            if(leadRecDetails != null && String.isNotEmpty(leadRecId)){
                leadRecDetails.Id = leadRecId;
                if(noEmployee != null){
                    leadRecDetails.NumberOfEmployees = Integer.ValueOf(noEmployee);
                }else if(noEmployee == null){
                    leadRecDetails.NumberOfEmployees = null;
                }
                update leadRecDetails;
            }
            
            if(String.isNotEmpty(leadRecId) && String.isNotEmpty(ldNotes) && String.isNotEmpty(ldTitle)){
                ContentVersion conVer = new ContentVersion();
                conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
                conVer.PathOnClient = ldTitle + '.snote';    // The files name, extension is very important here which will help the file in preview.
                conVer.Title = ldTitle; // Display name of the files
                Blob b=Blob.valueOf(ldNotes);

                //conVer.VersionData = EncodingUtil.base64Decode(b);
                conVer.VersionData = b; // converting your binary string to Blog
                insert conVer;
                System.debug('#####111'+conVer);
                // First get the content document Id from ContentVersion
                Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
                 
                //Create ContentDocumentLink
                ContentDocumentLink cDe = new ContentDocumentLink();
                cDe.ContentDocumentId = conDoc;
                cDe.LinkedEntityId = leadRecId; // you can use objectId,GroupId etc
                cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
                cDe.Visibility = 'AllUsers';
                insert cDe;
            }
            
        } catch (Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
        
    }    
    
    @AuraEnabled
    public static List <String> getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
         
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
         
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
         
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
        fieldMap.get(fld).getDescribe().getPickListValues();
         
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
           allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    
    @AuraEnabled
    public static List<Lead> getLeadDetails(String leadId) {
        List<Lead> leadResult = [SELECT Id,Name,FirstName,LastName,Gender__c,Tone_of_address__c,Language__c,Demo_date__c,Next_Step__c,FS_Next_Step_date__c,Potential_dealbreaker__c,Personalitiy__c,LeadSource,What_are_they_looking_for__c,Key_pain_point__c,Weekly_hours_spent_on_bookkeeping__c,Cash_journal_needed__c,
        Cash_journal_kept_in_compliant_way__c,Year_business_established__c,Legal_Form__c,Street,City,PostalCode,Country,Name_cash_register__c,Source_Revenues__c,
        VAT_declaration_extension_DFV__c,Separate_private_business_bank_account__c,Name_Bank_business_bank_account__c,AnnualRevenue,NumberOfEmployees,Qualification_type__c,Status,Lost_Reason_Lead__c,
        Zeitgold_Rejection_Reasons__c,Detailed_Lost_or_Rejection_Reason__c FROM Lead WHERE Id =: leadId];
        return leadResult;
    }
}