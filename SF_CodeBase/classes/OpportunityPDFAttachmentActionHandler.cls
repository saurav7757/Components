public class OpportunityPDFAttachmentActionHandler {
    public class InvalidInputException extends Exception {}
    
    @InvocableMethod(label='OpportunityPDFAttachmentActionHandler' description='Renders PDF contracts from Opportunity and adds them to its Files related list. These are expected to be used in the digital signing process.')
	public static void create(List<OpportunityPDFAttachmentInput> input) {
        if (input == null || input.size() != 1) {
            throw new InvalidInputException('One entry of input data is expected.');
        } 
        OpportunityPDFAttachmentInput ip = input.get(0);
        
        if (Test.isRunningTest() && !ip.runIfTestIsRunning) {
			System.debug('Exit. Running test does not target this feature.'); 	                              
        }
               
        generatePDFs(ip.opportunityID);
  	}
    
	private static void generatePDFs(ID oppID) {
        if (String.isBlank(oppID)) {
            throw new InvalidInputException('Opportunity ID is mandatory.');
        }
		
		OppDocumentGen odg = new OppDocumentGen(oppID);
        odg.GenerateDocs();
  	}
    
    public class OpportunityPDFAttachmentInput {
        @InvocableVariable(required=true)
        public ID opportunityID;
        
        public Boolean runIfTestIsRunning = false;
    }
}