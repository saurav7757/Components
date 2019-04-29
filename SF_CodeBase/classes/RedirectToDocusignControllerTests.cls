@isTest
public class RedirectToDocusignControllerTests {
	@isTest
    private static void testRedirect() {
        String sourceID = '1234';
        String CRL = 'crlValue';
        String CCRM = 'ccrmValue';
        PageReference pr = new PageReference('/apex/RedirectToDocusign?CCRM=' + ccrm + '&DSEID=0&SourceID=' + sourceID + '&CRL=' + crl);
        Test.setCurrentPage(pr);
        
        RedirectToDocusignController c = new RedirectToDocusignController();
        PageReference redirectPage = c.onInit();
        String redirectURL = redirectPage.getUrl();

        System.assert(redirectURL.startsWithIgnoreCase('/apex/dsfs__DocuSign_CreateEnvelope'));
        System.assert(redirectURL.containsIgnoreCase('DSEID=0'));
        System.assert(redirectURL.containsIgnoreCase('sid=' + sourceID));
        System.assert(redirectURL.containsIgnoreCase('CRL=' + CRL));
        System.assert(redirectURL.containsIgnoreCase('CCRM=' + CCRM));
    }
}