// class for ZG Page.
// AccountStartDate should be required.
public class PioneerCtl {
    public Opportunity o { get; set; }
    public Account a { get; set; }
    public Contact c { get; set; }
    public OpportunityContactRole shareholder1 { get; set; }
    
    public string getDate() {
        date d = date.today();
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
    
    private string legalType() {
        return LegalEntity.Convert(a.Legal_Form__c);
    }
    
    public string getLegalType() {
        return legalType();
    }
    
    public boolean getPersG() {
        return legalType() == 'PersG';
    }
    
    public boolean getKapG() {
        return legalType() == 'KapG';
    }
    
    public boolean getEU() {
        return legalType() == 'EU';
    }
            
    public string getLegalCity() {
        return a.BillingCity;
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
    
    public String getLegalName() {
        return o.Account.Company_Legal_Name__c;        
    }  
    public String getMRR() {
        return toCurrency(o.MRR_Zeitgold__c) + '€';
    }
    
    public string getAccountingStartDate() {
        return toDate(a.Accounting_Start_Date__c);
    }
    
    public string getPayrollOnboardingDate() {
        return toDate(a.Payroll_Start_Date__c);
    }
    
    public string getMonthlyTaxAdvisorFee() {
        return toCurrency(o.MRR_Tax_Advisor__c) + '€';
    }
    
    public string getOneTimeAnnualTaxAdvisorFee() {
        return o.ARR_Tax_Advisor_Year_End_Statement__c + '€';
    }
    
    public string getTotalAnnualTaxAdvisorFee() {
        return '<ARR_Tax__c>' + '€';
        //return toCurrency(o.ARR_Tax__c) + '€';
    }
    
    public string getTotalMonthlyTaxAdvisorFee() {
        return '<ARR_Monthly_Tax__c>' + '€';
        //return toCurrency(o.ARR_Monthly_Tax__c) + '€';
    }
        
    public string getOfferExpirationDate() {
        return toDate(o.Offer_expiration_date__c);
    }
    
    public string getSigningAnchors() {
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
    
    public string getAnnualTaxAdvisorServices1() {
        switch on getLegalType() {
            when 'PersG'{
                return '<ul>' +
                        '<li>' +
                          'Jahresabschluss bzw. Überschuss-Ermittlung von Betriebseinnahmen über Betriebsausgaben' +
                        '</li>' +
                        '<li>' +
                          'Ggf. Durchführung der Jahresabschluss-Offenlegung bzw. Hinterlegung beim Bundesanzeiger' +
                        '</li>' +
                        '<li>' +
                          'Erstellung der Umsatzsteuerjahreserklärung' +
                        '</li>' +
                        '<li>' +
                          'Prüfung einmaliger Bescheide und Zusendung (falls Empfangsvollmacht für uns erteilt!)' +
                        '</li>' +                    
                      '</ul>';
            }
            when 'EU'{
                return '<ul>' +
                        '<li>' +
                          'Ermittlung des Überschusses der Betriebseinnahmen über die Betriebsausgaben' +
                        '</li>' +
                        '<li>' +
                          'Erstellung der Umsatzsteuerjahreserklärung' +
                        '</li>' +
                        '<li>' +
                          'Erstellung der Gewerbesteuererklärung' +
                        '</li>' +
                        '<li>' +
                          'Prüfung einmaliger Bescheide und Zusendung (falls Empfangsvollmacht für uns erteilt!)' +
                        '</li>' +                    	
                      '</ul>';
            }
            when 'KapG'{
                return '<ul>' +
                        '<li>' +
                          'Erstellung des Jahresabschlusses (Handelsbilanz), bestehend aus Bilanz, GuV und Anhang' +
                        '</li>' +
                    	'<li>' +
                          'Steuerliches Ergebnis mittels Steuerbilanz oder Überleitungsrechnung mittels Handelsbilanz' +
                        '</li>' +
                        '<li>' +
                          'Erstellung der elektronischen Übermittlung der E-Bilanz' +
                        '</li>' +
                        '<li>' +
                          'Durchführung der Offenlegung bzw. Hinterlegung beim Bundesanzeiger' +
                        '</li>' +
                        '<li>' +
                          'Erstellung der Umsatzsteuerjahreserklärung' +
                        '</li>' +
                    	'<li>' +
                          'Erstellung der Gewerbesteuererklärung' +
                        '</li>' +
                    	'<li>' +
                          'Erstellung der Körperschaftsteuererklärung' +
                        '</li>' +
                    	'<li>' +
                          'Prüfung einmaliger Bescheide und Zusendung (falls Empfangsvollmacht für uns erteilt!)' +
                        '</li>' +
                      '</ul>';
            }
            when else {
                return '';
            }
        }        
    }    
    public string getAnnualTaxAdvisorServices2() {
        switch on getLegalType() {
            when 'PersG'{
                return '<p>' +
                    	'Folgende Leistungen sind nicht im Pauschal-Paket enthalten und werden gesondert gemäß der Vergütungsvereinbarung abgerechnet:' +
                        '<ul>' +
                            '<li>' +
                              'Erstellung von eventuell erforderlichen Ergänzungs- und Sonderbilanzen' +
                            '</li>' +
                            '<li>' +
                              'Steuerliches Ergebnis mittels Steuerbilanz oder Überleitungsrechnung mittels Handelsbilanz' +
                            '</li>' +
                            '<li>' +
                              'Gewerbesteuererklärung' +
                            '</li>' +
                            '<li>' +
                              'E-Bilanz (Erstellung und elektronische Übermittlung)' +
                            '</li>' +
                    		'<li>' +
                              'Erklärung zur gesonderten und einheitlichen Feststellung von Grundlagen für die Einkommensbesteuerung' +
                            '</li>' +
                        '</ul>' + 
                       '</p>';
            }             
            when else {
                return '';
            }
        }
    }
    
    public PioneerCtl() {
        Id oid = ApexPages.currentPage().getParameters().get('id');
        
        o = [
            SELECT id, name, MRR_Zeitgold__c, Offer_expiration_date__c,
            MRR_Tax_Advisor__c,
            ARR_Tax_Advisor_Year_End_Statement__c,
            //ARR_Tax__c, // TODO: fields to be added
            //ARR_Monthly_Tax__c,
            Account.Company_Legal_Name__c, Account.Name,
            Account.Accounting_Start_Date__c,
            Account.Payroll_Start_Date__c,
            Account.Legal_Form__c,
            Account.BillingCity, Account.BillingCountry,
            Account.BillingStreet, Account.BillingPostalCode,
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