public class SignWithDocusignController {
	public class InvalidInputException extends Exception {}
    
    @AuraEnabled
    public static OpportunityContactRole[] getSigningConfig(String oppID) {
        System.debug('SignWithDocusignController :: triggerSigning');
        if (String.isBlank(oppID)) {
            throw new InvalidInputException('Opportunity ID is mandatory.');
        }
        
        OpportunityContactRole[] config = [
            SELECT  ID,
            		Role,
            		Contact.LastName,
            		Contact.Email
            FROM OpportunityContactRole
            WHERE OpportunityId = :oppID AND role like 'Shareholder%'
        ];
        System.debug('SignWithDocusignController :: config: ' + config);
        
        return config;        
    }
}