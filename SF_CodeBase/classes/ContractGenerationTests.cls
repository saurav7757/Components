@isTest
public class ContractGenerationTests {
    private static ID insertOpportunityAndOthers() {
        Account a = new Account(name = 'test',
                                billingStreet = 'Street',
                                billingCity = 'City',
                                billingCountry = 'Country',
                                billingPostalCode = '1111',
                                annualRevenue = 10000,
                                Controlling_requirements_beyond_BWA__c = 'No special requirements',
                                Installment_payments__c = 'No installment payments',
                                No_of_incoming_invoices_per_month__c = 10,
                                No_of_outgoing_invoices_per_month__c = 15,
                                NumberOfEmployees = 100,
                                Short_time_work__c = 'No short time work',
                                Source_Revenues__c = 'Barter',
                                Special_balance_sheet_structure__c = 'Unknown',
                                VAT_declaration_extension_DFV__c = 'They don\'t know if they have the extension');
        insert a;
        
        Contact c = new Contact(lastName = 'test', accountID = a.ID);
        insert c;
        
        Opportunity o = new Opportunity(name = 'test',
                                        stageName = 'Verbal Commitment',
                                        closeDate = Date.today(),
                                        demo_Completed__c = 'Yes',                                        
                                        ARR_Tax_Advisor_Year_End_Statement__c = 15000,
                                        Demo_date__c = Date.today().addDays(-10),
                                        Pricing_Model__c = 'Pricing A',
                                        accountID = a.ID);
        insert o;
        
        OpportunityContactRole ocr = new OpportunityContactRole(opportunityID = o.ID,
                                                                contactID = c.ID,
                                                                role = 'Shareholder1');
        insert ocr;
        
        return o.ID;
    }
    
    @isTest
    private static void testPioneer() {                
        ID oID = insertOpportunityAndOthers();
        
        Test.setCurrentPage(Page.PioneerContract);
        ApexPages.currentPage().getParameters().put('id', oID);
        PioneerCtl p = new PioneerCtl();
                
        // note: these are here just to cover the minimum test coverage
        // real testing to be written
        p.getDate();
        p.getLegalType();
        p.getPersG();
        p.getKapG();
        p.getEU();
        p.getLegalCity();
        p.getLegalCountry();
        p.getLegalPostCode();
        p.getLegalStreet();
        p.getLegalName();
        p.getMRR();
        p.getAccountingStartDate();
        p.getPayrollOnboardingDate();
        p.getMonthlyTaxAdvisorFee();
        p.getOneTimeAnnualTaxAdvisorFee();
        p.getTotalAnnualTaxAdvisorFee();
        p.getTotalMonthlyTaxAdvisorFee();
        p.getOfferExpirationDate();
        p.getSigningAnchors();
        p.getAnnualTaxAdvisorServices1();
        p.getAnnualTaxAdvisorServices2();        
    }

    @isTest
    private static void testZeitgold() {
        ID oID = insertOpportunityAndOthers();
        
        Test.setCurrentPage(Page.ZeitgoldContract);
        ApexPages.currentPage().getParameters().put('id', oID);
        ZeitgoldCtl p = new ZeitgoldCtl();
                
        // note: these are here just to cover the minimum test coverage
        // real testing to be written
        p.getDate();
        p.getLegalType();        
        p.getLegalCity();
        p.getLegalCountry();
        p.getLegalPostCode();
        p.getLegalStreet();
        p.getLegalName();
        p.getLegalForm();
        p.getSalutation();
        p.getMRR();
        p.getAnnualRevenue();
        p.getBasisPauschale();
        p.getLohnbuchhaltung();
        p.getMonatlichePauschale();
        p.getjahrlichePauschale();
        p.getAccountingStartDate();
        p.getPayrollOnboardingDate();
        p.getOfferExpirationDate();
        p.getSigningAnchors();
    }
    
    @isTest
    private static void testOpportunityPDFAttachments() {
        ID oID = insertOpportunityAndOthers();
        
        // fails with no opp
        try {
            OpportunityPDFAttachmentsController.generateContractsMan(null);    
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
        
        OpportunityPDFAttachmentsController.generateContractsMan(oID);
        
        Test.startTest();
        Integer attCount = [SELECT Count() FROM Attachment WHERE ParentId = :oID];        
        Test.stopTest();
        
        System.assertEquals(2, attCount);
    }
    
    @isTest
    private static void testOpportunityPDFAttachmentsActionHandler() {
        ID oID = insertOpportunityAndOthers();
        
        // fails with no input
        try {
            OpportunityPDFAttachmentActionHandler.create(null);
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
        
        OpportunityPDFAttachmentActionHandler.OpportunityPDFAttachmentInput i = new OpportunityPDFAttachmentActionHandler.OpportunityPDFAttachmentInput();
        i.opportunityID = oID;
        i.runIfTestIsRunning = true;
        OpportunityPDFAttachmentActionHandler.create(new OpportunityPDFAttachmentActionHandler.OpportunityPDFAttachmentInput[]{i});
        
        Test.startTest();
        Integer attCount = [SELECT Count() FROM Attachment WHERE ParentId = :oID];        
        Test.stopTest();
        
        System.assertEquals(2, attCount);
    }
    
    @isTest
    private static void testSigningConfig() {
        ID oID = insertOpportunityAndOthers();
        
        // fails with no opp
        try {
            SignWithDocusignController.getSigningConfig(null);
            System.assert(false);
        } catch(Exception e) {
            System.assert(true);
        }
        
        OpportunityContactRole[] ocrs = SignWithDocusignController.getSigningConfig(oID);
        System.assertEquals(1, ocrs.size());
    }
}