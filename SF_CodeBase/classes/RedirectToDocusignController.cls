// This page/controller exists just to grab the CSRF token and pass it along to the Docusign page.
// Intended to be called from a lightning component with no direct access to the token.
public class RedirectToDocusignController {
    public String message {get; set;}
    public PageReference onInit() {
        Map<String, String> m = ApexPages.currentPage().getParameters();
        PageReference p = new PageReference('/apex/dsfs__DocuSign_CreateEnvelope?DSEID=0');
        p.getParameters().put('CRL', m.get('CRL'));
        p.getParameters().put('CCRM', m.get('CCRM'));
        p.getParameters().put('sId', m.get('SourceID'));
        p.setRedirect(true);
        
        return p;
    }
}