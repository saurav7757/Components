// class for ZG Page.
public class ZeitgoldCtl {
    public Opportunity o { get; set; }
    public Account a { get; set; }
    public Contact c { get; set; }
    public OpportunityContactRole shareholder1 { get; set; }
    
    public String getDate() {
        Date d = Date.today();
        return toDate(d);
    }
    
    private string toDate(Date d) {
        if (d == null) {
            return 'no date';
        }
        return StringFormatter.defaultFormatted(d);
    }
    
    private string toCurrency(Decimal d) {
        if (d == null) {
            return '';
        }
        
		return StringFormatter.noDecimals(d);
    }
    
    public string getLegalCity() {
        return a.BillingCity ;
    }
    public string getLegalCountry() {
        return a.BillingCountry; 
    }
    public string getLegalPostCode() {
        return a.BillingPostalCode;
    }
    public string getLegalStreet() {
        return a.BillingStreet;
    }
    public string getLegalType() {
        return LegalEntity.Convert(a.Legal_Form__c);
    }
    public string getLegalForm(){
        return a.Legal_Form__c;
    }
    
    public String getLegalName() {
        return o.Account.Company_Legal_Name__c;        
    } 
    public string getSalutation() {
        return c.Name;
    }
    public String getMRR() {
        return toCurrency(o.MRR_Zeitgold__c) + '€';
    }
    
    public String getAnnualRevenue() {
        return toCurrency(a.AnnualRevenue);
    }
    public String getBasisPauschale() {
        return toCurrency(o.MRR_Zeitgold__c);
    }
    public String getLohnbuchhaltung() {
        return toCurrency(a.Amount_Wage_Account__c);
    }
    public String getMonatlichePauschale() {
        return toCurrency(o.MRR_Tax_Advisor__c);
    }
	public String getjahrlichePauschale() {
        return toCurrency(o.ARR_Tax_Advisor_Year_End_Statement__c);
    }    
        
    public string getAccountingStartDate() {
        return toDate(a.Accounting_Start_Date__c);
    }
    
    public string getPayrollOnboardingDate() {
        return toDate(a.Payroll_Start_Date__c);
    }
    
    public string getOfferExpirationDate() {
        return toDate(o.Offer_expiration_date__c);
    }
    
    public string getSigningAnchors() {
    	return signingAnchors(false);
    }
    
    public string getSigningAnchorsShort() {
    	return signingAnchors(true);
    }
    
    private string signingAnchors(Boolean shortenWidth) {
    	Integer count = [
            SELECT  Count()
            FROM OpportunityContactRole
            WHERE OpportunityId = :this.o.ID AND role like 'Shareholder%'
        ];
        string anchors = '';
        for (Integer i = 1; i <= count; ++i) {
            anchors += '<span class="s_anchor white">\\s' + String.valueOf(i) + '\\' + '</span>';
        }
        return anchors;
    }
    
    public ZeitgoldCtl() {
        Id oid = ApexPages.currentPage().getParameters().get('id');
        
        o = [
            SELECT id, name, MRR_Zeitgold__c, Offer_expiration_date__c,
            MRR_Tax_Advisor__c, ARR_Tax_Advisor_Year_End_Statement__c,
            Account.Company_Legal_Name__c,
            Account.Name,
            Account.Accounting_Start_Date__c,
            Account.Payroll_Start_Date__c,
            Account.BillingStreet,
            Account.BillingPostalCode,
            Account.BillingCity,
            Account.BillingCountry,
            Account.Legal_Form__c,
            Account.AnnualRevenue,
            Account.No_of_incoming_invoices_per_month__c, Account.No_of_outgoing_invoices_per_month__c,
            Account.NumberOfEmployees,
            Account.Amount_Wage_Account__c
            FROM Opportunity 
            WHERE id = :oid
        ]; 
        a = o.Account;
        
        List<Contact> contacts = [
            SELECT ID, Name
            FROM Contact
            WHERE Account.Id = :a.Id
            LIMIT 1
        ];
        c = contacts[0];
        
        OpportunityContactRole[] shareholder1s = [
            SELECT Contact.Name, Contact.Email, Role
            FROM OpportunityContactRole
            WHERE OpportunityID = :oid AND Role = 'Shareholder1' LIMIT 1
        ];
        if (!shareholder1s.isEmpty()) {
            this.shareholder1 = shareholder1s[0];
        }
    }
}