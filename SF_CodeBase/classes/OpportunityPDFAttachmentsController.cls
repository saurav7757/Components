public class OpportunityPDFAttachmentsController {
    public class InvalidInputException extends Exception {}
    
    @AuraEnabled
    public static void generateContractsMan(String oppID) {
        System.debug('OpportunityPDFAttachmentsController :: generateContracts');
        if (String.isBlank(oppID)) {
            throw new InvalidInputException('Opportunity ID is mandatory.');
        }
        OppDocumentGen odg = new OppDocumentGen(oppID);
        odg.GenerateDocs();
    }
}