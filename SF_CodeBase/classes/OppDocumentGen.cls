public class OppDocumentGen {
    private string oppId;
    
    public OppDocumentGen(string oppId) {
        this.oppId = oppId;
    }
    
    public void GenerateDocs() {
        List<Attachment> attachments = new List<Attachment>();
        attachments.add(generateDocument('Zeitgold', Page.ZeitgoldContract));      
        attachments.add(generateDocument('Pioneer', Page.PioneerContract));
        insert attachments;
    }
    
    private Attachment generateDocument(string name, PageReference pageRef) {
		pageRef.getParameters().put('id', this.oppId);
	        
        Blob blobFromPDF = null;
        try {                              
            blobFromPDF = pageRef.getContent();  
        } catch (VisualforceException e) {
            blobFromPDF = Blob.valueOf('failedtogen');
        }                              
        
        Attachment ex = new Attachment();
        ex.Body = blobFromPDF;
        ex.Name = name + Datetime.now().format('_yyyy-MM-dd_HH:mm:ss') + '.pdf';
        ex.ParentId = this.oppId;
        
        return ex;  
    }
}