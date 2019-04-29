({
   doInit: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      
   }, 
    
   openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
      var oppId = component.get("v.recordId");
      //alert('Opp Id' + oppId);
       //console.log('####'+label);
	  //component.set("v.RecId", label);
	  
	  //helper.fetchPickListValAcc(component, 'Onboarding_Process__c', 'ONBProcess');
	  helper.fetchPickListValCont(component, 'Salutation', 'salnameZG');
	  helper.fetchPickListValCont(component, 'Language__c', 'LanguageZG');
	  helper.fetchPickListValCont(component, 'Tone_of_address__c', 'ToneZG');
	  helper.fetchPickListValAcc(component, 'Industry', 'AccInd');
	  helper.fetchPickListValAcc(component, 'Industry_Type__c', 'AccIndType');
      helper.fetchPickListValAcc(component, 'CEP_Migration_necessary__c', 'cepNecc');
	  helper.fetchPickListValAcc(component, 'VAT_declaration_cadence__c', 'vatDecl');
	  helper.fetchPickListValAcc(component, 'VAT_declaration_extension_DFV__c', 'vatDeclDFV');
	  helper.fetchPickListValCont(component, 'Salutation', 'salnameZG1');
	  helper.fetchPickListValCont(component, 'Language__c', 'LanguageZG1');
	  helper.fetchPickListValCont(component, 'Tone_of_address__c', 'ToneZG1');
	  helper.fetchPickListValAcc(component, 'Is_ZG_First_Contact_and_Shareholder_same__c', 'sameZGandShrHol');
      helper.getPrefilledZGDetails(component, event, oppId);
	  
	  //if(component.get("v.LeadDetails.Status") == 'Closed Lost'){
		//helper.fetchPickListVal(component, 'Lost_Reason_Lead__c', 'lostRsn');
	  //}
	  //alert('gfgfgf' + component.get("v.LeadDetails.Status"));
	  //if(component.get("v.LeadDetails.Status") == 'Rejected'){
		//helper.fetchPickListVal(component, 'Zeitgold_Rejection_Reasons__c', 'InputSelectMultiplerejRsns');
	  //}
	  //var recIdLead = component.get("v.recordId");
	  helper.getOppPerFillDetails(component, event, oppId);
       //var dfdf = component.get("v.selectedLookUpRecord");
       //component.set("v.selectedLookUpRecord12", dfdf);
	  //$A.enqueueAction(component.get('c.renderOtherLeadDetails'));
	  //$A.enqueueAction(component.get('c.handleGenreChangeForSrc'));
	  //$A.enqueueAction(component.get('c.handleGenreChangeForRejRsns'));
	   //helper.fetchPickListVal(component, 'Ac_Salutation__c', 'salnameZG1');
	  		//helper.fetchPickListVal(component, 'Ac_Preferred_Language_of_1st_ZG_Contact__c', 'LanguageZG1');
	  		//helper.fetchPickListVal(component, 'Ac_Tone_of_address__c', 'ToneZG1');
      helper.getPrefilledShrHoldDetails(component, event, oppId);
	  helper.getPrefilledParentAccDetails(component, event, oppId);
	  
   },
   
   onSingleSelectChange: function(component, event, helper) {
	   var getResr = component.find("sameZGandShrHol").get("v.value");
       var oppIds = component.get("v.recordId");
	   
	   if(getResr == 'Yes'){
		   //component.set("v.isRenderZGComp", true);
           //helper.fetchPickListVal(component, 'Ac_Salutation__c', 'salnameZG1');
	  		helper.fetchPickListVal(component, 'Ac_Preferred_Language_of_1st_ZG_Contact__c', 'LanguageZG1');
	  		helper.fetchPickListVal(component, 'Ac_Tone_of_address__c', 'ToneZG1');
           helper.setSameZGandShrHolder(component, event);
       }else if(getResr == 'No'){
           //component.set("v.isRenderZGComp", true);
           //helper.fetchPickListVal(component, 'Ac_Salutation__c', 'salnameZG1');
	  		helper.fetchPickListVal(component, 'Ac_Preferred_Language_of_1st_ZG_Contact__c', 'LanguageZG1');
	  		helper.fetchPickListVal(component, 'Ac_Tone_of_address__c', 'ToneZG1');
           helper.getPrefilledShrHoldDetails(component, event, oppIds);
      }
   },
 
   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
	  //component.set("v.isRender", false);
   },
   
	
   saveandHandOver: function(component, event, helper) {
		var optDetails = component.get("v.OppDetails");
		var acDetails = component.get("v.accDetails");
		var coDetailsZG = component.get("v.conDetailsFrstZGCon");
		var coDetailsShr = component.get("v.conDetailsShrHold");
		var isNotFilled = true;
		//Validation
        if($A.util.isEmpty(acDetails.Go_Live_Date__c) || $A.util.isUndefined(acDetails.Go_Live_Date__c)){
            component.find("goliveDate").set("v.errors", [{message: 'Field is Required'}]);
			isNotFilled = false;
        }else {
			component.find("goliveDate").set("v.errors", null);
		}            
		if($A.util.isEmpty(coDetailsZG.Salutation) || $A.util.isUndefined(coDetailsZG.Salutation)){
            component.find("salnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.FirstName) || $A.util.isUndefined(coDetailsZG.FirstName)){
            component.find("frstnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("frstnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.LastName) || $A.util.isUndefined(coDetailsZG.LastName)){
            component.find("lstnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lstnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Email) || $A.util.isUndefined(coDetailsZG.Email)){
            component.find("EmailZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("EmailZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Phone) || $A.util.isUndefined(coDetailsZG.Phone)){
            component.find("PhoneZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("PhoneZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Language__c) || $A.util.isUndefined(coDetailsZG.Language__c)){
            component.find("LanguageZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("LanguageZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Tone_of_address__c) || $A.util.isUndefined(coDetailsZG.Tone_of_address__c)){
            component.find("ToneZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("ToneZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Title) || $A.util.isUndefined(coDetailsZG.Title)){
            component.find("TitleZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("TitleZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Salutation) || $A.util.isUndefined(coDetailsShr.Salutation)){
            component.find("salnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.FirstName) || $A.util.isUndefined(coDetailsShr.FirstName)){
            component.find("frstnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("frstnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.LastName) || $A.util.isUndefined(coDetailsShr.LastName)){
            component.find("lstnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lstnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Email) || $A.util.isUndefined(coDetailsShr.Email)){
            component.find("EmailZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("EmailZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Phone) || $A.util.isUndefined(coDetailsShr.Phone)){
            component.find("PhoneZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("PhoneZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Language__c) || $A.util.isUndefined(coDetailsShr.Language__c)){
            component.find("LanguageZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("LanguageZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Tone_of_address__c) || $A.util.isUndefined(coDetailsShr.Tone_of_address__c)){
            component.find("ToneZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("ToneZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Title) || $A.util.isUndefined(coDetailsShr.Title)){
            component.find("TitleZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("TitleZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Is_ZG_First_Contact_and_Shareholder_same__c) || $A.util.isUndefined(acDetails.Is_ZG_First_Contact_and_Shareholder_same__c)){
            component.find("sameZGandShrHol").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("sameZGandShrHol").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Company_Legal_Name__c) || $A.util.isUndefined(acDetails.Company_Legal_Name__c)){
            component.find("CompLeg").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("CompLeg").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Name) || $A.util.isUndefined(acDetails.Name)){
            component.find("AccNames").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccNames").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Industry) || $A.util.isUndefined(acDetails.Industry)){
            component.find("AccInd").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccInd").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Industry_Type__c) || $A.util.isUndefined(acDetails.Industry_Type__c)){
            component.find("AccIndType").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccIndType").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingStreet) || $A.util.isUndefined(acDetails.BillingStreet)){
            component.find("lastreet").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lastreet").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingCountry) || $A.util.isUndefined(acDetails.BillingCountry)){
            component.find("lacity").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lacity").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Nature_Purpose_of_business__c) || $A.util.isUndefined(acDetails.Nature_Purpose_of_business__c)){
            component.find("natandpurp").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("natandpurp").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingCity) || $A.util.isUndefined(acDetails.BillingCity)){
            component.find("lacountry").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lacountry").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingPostalCode) || $A.util.isUndefined(acDetails.BillingPostalCode)){
            component.find("lapostalcode").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lapostalcode").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.MRR_Zeitgold__c) || $A.util.isUndefined(optDetails.MRR_Zeitgold__c)){
            component.find("mrrzg").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("mrrzg").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.MRR_Tax_Advisor__c) || $A.util.isUndefined(optDetails.MRR_Tax_Advisor__c)){
            component.find("mrrtax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("mrrtax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_Initial_MRR_w_o_Tax_Advisor_F__c) || $A.util.isUndefined(optDetails.Special_Initial_MRR_w_o_Tax_Advisor_F__c)){
            component.find("spcintmrr").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("spcintmrr").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_Initial_MRR_Valid_for_how_many_m__c) || $A.util.isUndefined(optDetails.Special_Initial_MRR_Valid_for_how_many_m__c)){
            component.find("splmrrmonths").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("splmrrmonths").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Total_monthly_Tax_advisor_fee__c) || $A.util.isUndefined(optDetails.Total_monthly_Tax_advisor_fee__c)){
            component.find("totaltax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("totaltax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Total_annual_tax_advisor_fee__c) || $A.util.isUndefined(optDetails.Total_annual_tax_advisor_fee__c)){
            component.find("totalannualtax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("totalannualtax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.ARR_Tax_Advisor_Year_End_Statement__c) || $A.util.isUndefined(optDetails.ARR_Tax_Advisor_Year_End_Statement__c)){
            component.find("arrtaxadv").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("arrtaxadv").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Link_to_sales_offer__c) || $A.util.isUndefined(acDetails.Link_to_sales_offer__c)){
            component.find("linktosls").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("linktosls").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_offer_Other_if_applicable__c) || $A.util.isUndefined(optDetails.Special_offer_Other_if_applicable__c)){
            component.find("splofferappl").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("splofferappl").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Accounting_Start_Date__c) || $A.util.isUndefined(acDetails.Accounting_Start_Date__c)){
            component.find("accstartdate").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("accstartdate").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_offer_PIO_if_applicable__c) || $A.util.isUndefined(optDetails.Special_offer_PIO_if_applicable__c)){
            component.find("spcPIO").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("spcPIO").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.AnnualRevenue) || $A.util.isUndefined(acDetails.AnnualRevenue)){
            component.find("annualRev").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("annualRev").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Payroll_Start_Date__c) || $A.util.isUndefined(acDetails.Payroll_Start_Date__c)){
            component.find("payStartdate").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("payStartdate").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Name_cash_register__c) || $A.util.isUndefined(acDetails.Name_cash_register__c)){
            component.find("namecash").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("namecash").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.CEP_Migration_necessary__c) || $A.util.isUndefined(acDetails.CEP_Migration_necessary__c)){
            component.find("cepNecc").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("cepNecc").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.VAT_declaration_cadence__c) || $A.util.isUndefined(acDetails.VAT_declaration_cadence__c)){
            component.find("vatDecl").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("vatDecl").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.VAT_declaration_extension_DFV__c) || $A.util.isUndefined(acDetails.VAT_declaration_extension_DFV__c)){
            component.find("vatDeclDFV").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("vatDeclDFV").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Sales_related_comments_for_ONB_and_CE__c) || $A.util.isUndefined(acDetails.Sales_related_comments_for_ONB_and_CE__c)){
            component.find("salerelcomment").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salerelcomment").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Problems_with_old_Advisors_Providers__c) || $A.util.isUndefined(acDetails.Problems_with_old_Advisors_Providers__c)){
            component.find("probwithOldAdv").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("probwithOldAdv").set("v.errors", null);
		}
		if($A.util.isEmpty(component.get("v.employeeNumber")) || $A.util.isUndefined(component.get("v.employeeNumber"))){
            component.find("noofemp").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("noofemp").set("v.errors", null);
		}
		if($A.util.isEmpty(component.get("v.selectedLookUpRecord")) || $A.util.isUndefined(component.get("v.selectedLookUpRecord"))){
            component.find("firstZeitgCont").set("v.value", "Field is Required");
            isNotFilled = false;
        }else {
			component.find("firstZeitgCont").set("v.value", null);
		}
		if($A.util.isEmpty(component.get("v.selectedLookUpRecordForShareHolder")) || $A.util.isUndefined(component.get("v.selectedLookUpRecordForShareHolder"))){
            //alert('in lookup' + component.get("v.selectedLookUpRecordForShareHolder").Id);
			component.find("firstShareCont").set("v.value", "Field is Required");
            isNotFilled = false;
        }else {
			component.find("firstShareCont").set("v.value", null);
		}
		console.log('$$$$$$$2345' + isNotFilled);
		if(isNotFilled == false){
			return;
		}
		component.set("v.showModal", true);
   },
   
   saveAndCloseWon : function(component, event, helper) {
      var optDetails = component.get("v.OppDetails");
	  var acDetails = component.get("v.accDetails");
	  var coDetailsZG = component.get("v.conDetailsFrstZGCon");
	  var coDetailsShr = component.get("v.conDetailsShrHold");
		var isNotFilled = true;
		//Validation
        if($A.util.isEmpty(acDetails.Go_Live_Date__c) || $A.util.isUndefined(acDetails.Go_Live_Date__c)){
            component.find("goliveDate").set("v.errors", [{message: 'Field is Required'}]);
			isNotFilled = false;
        }else {
			component.find("goliveDate").set("v.errors", null);
		}            
		if($A.util.isEmpty(coDetailsZG.Salutation) || $A.util.isUndefined(coDetailsZG.Salutation)){
            component.find("salnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.FirstName) || $A.util.isUndefined(coDetailsZG.FirstName)){
            component.find("frstnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("frstnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.LastName) || $A.util.isUndefined(coDetailsZG.LastName)){
            component.find("lstnameZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lstnameZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Email) || $A.util.isUndefined(coDetailsZG.Email)){
            component.find("EmailZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("EmailZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Phone) || $A.util.isUndefined(coDetailsZG.Phone)){
            component.find("PhoneZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("PhoneZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Language__c) || $A.util.isUndefined(coDetailsZG.Language__c)){
            component.find("LanguageZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("LanguageZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Tone_of_address__c) || $A.util.isUndefined(coDetailsZG.Tone_of_address__c)){
            component.find("ToneZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("ToneZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsZG.Title) || $A.util.isUndefined(coDetailsZG.Title)){
            component.find("TitleZG").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("TitleZG").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Salutation) || $A.util.isUndefined(coDetailsShr.Salutation)){
            component.find("salnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.FirstName) || $A.util.isUndefined(coDetailsShr.FirstName)){
            component.find("frstnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("frstnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.LastName) || $A.util.isUndefined(coDetailsShr.LastName)){
            component.find("lstnameZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lstnameZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Email) || $A.util.isUndefined(coDetailsShr.Email)){
            component.find("EmailZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("EmailZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Phone) || $A.util.isUndefined(coDetailsShr.Phone)){
            component.find("PhoneZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("PhoneZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Language__c) || $A.util.isUndefined(coDetailsShr.Language__c)){
            component.find("LanguageZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("LanguageZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Tone_of_address__c) || $A.util.isUndefined(coDetailsShr.Tone_of_address__c)){
            component.find("ToneZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("ToneZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(coDetailsShr.Title) || $A.util.isUndefined(coDetailsShr.Title)){
            component.find("TitleZG1").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("TitleZG1").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Is_ZG_First_Contact_and_Shareholder_same__c) || $A.util.isUndefined(acDetails.Is_ZG_First_Contact_and_Shareholder_same__c)){
            component.find("sameZGandShrHol").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("sameZGandShrHol").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Company_Legal_Name__c) || $A.util.isUndefined(acDetails.Company_Legal_Name__c)){
            component.find("CompLeg").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("CompLeg").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Name) || $A.util.isUndefined(acDetails.Name)){
            component.find("AccNames").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccNames").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Industry) || $A.util.isUndefined(acDetails.Industry)){
            component.find("AccInd").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccInd").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Industry_Type__c) || $A.util.isUndefined(acDetails.Industry_Type__c)){
            component.find("AccIndType").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("AccIndType").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingStreet) || $A.util.isUndefined(acDetails.BillingStreet)){
            component.find("lastreet").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lastreet").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingCountry) || $A.util.isUndefined(acDetails.BillingCountry)){
            component.find("lacity").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lacity").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Nature_Purpose_of_business__c) || $A.util.isUndefined(acDetails.Nature_Purpose_of_business__c)){
            component.find("natandpurp").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("natandpurp").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingCity) || $A.util.isUndefined(acDetails.BillingCity)){
            component.find("lacountry").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lacountry").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.BillingPostalCode) || $A.util.isUndefined(acDetails.BillingPostalCode)){
            component.find("lapostalcode").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("lapostalcode").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.MRR_Zeitgold__c) || $A.util.isUndefined(optDetails.MRR_Zeitgold__c)){
            component.find("mrrzg").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("mrrzg").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.MRR_Tax_Advisor__c) || $A.util.isUndefined(optDetails.MRR_Tax_Advisor__c)){
            component.find("mrrtax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("mrrtax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_Initial_MRR_w_o_Tax_Advisor_F__c) || $A.util.isUndefined(optDetails.Special_Initial_MRR_w_o_Tax_Advisor_F__c)){
            component.find("spcintmrr").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("spcintmrr").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_Initial_MRR_Valid_for_how_many_m__c) || $A.util.isUndefined(optDetails.Special_Initial_MRR_Valid_for_how_many_m__c)){
            component.find("splmrrmonths").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("splmrrmonths").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Total_monthly_Tax_advisor_fee__c) || $A.util.isUndefined(optDetails.Total_monthly_Tax_advisor_fee__c)){
            component.find("totaltax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("totaltax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Total_annual_tax_advisor_fee__c) || $A.util.isUndefined(optDetails.Total_annual_tax_advisor_fee__c)){
            component.find("totalannualtax").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("totalannualtax").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.ARR_Tax_Advisor_Year_End_Statement__c) || $A.util.isUndefined(optDetails.ARR_Tax_Advisor_Year_End_Statement__c)){
            component.find("arrtaxadv").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("arrtaxadv").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Link_to_sales_offer__c) || $A.util.isUndefined(acDetails.Link_to_sales_offer__c)){
            component.find("linktosls").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("linktosls").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_offer_Other_if_applicable__c) || $A.util.isUndefined(optDetails.Special_offer_Other_if_applicable__c)){
            component.find("splofferappl").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("splofferappl").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Accounting_Start_Date__c) || $A.util.isUndefined(acDetails.Accounting_Start_Date__c)){
            component.find("accstartdate").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("accstartdate").set("v.errors", null);
		}
		if($A.util.isEmpty(optDetails.Special_offer_PIO_if_applicable__c) || $A.util.isUndefined(optDetails.Special_offer_PIO_if_applicable__c)){
            component.find("spcPIO").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("spcPIO").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.AnnualRevenue) || $A.util.isUndefined(acDetails.AnnualRevenue)){
            component.find("annualRev").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("annualRev").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Payroll_Start_Date__c) || $A.util.isUndefined(acDetails.Payroll_Start_Date__c)){
            component.find("payStartdate").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("payStartdate").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Name_cash_register__c) || $A.util.isUndefined(acDetails.Name_cash_register__c)){
            component.find("namecash").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("namecash").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.CEP_Migration_necessary__c) || $A.util.isUndefined(acDetails.CEP_Migration_necessary__c)){
            component.find("cepNecc").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("cepNecc").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.VAT_declaration_cadence__c) || $A.util.isUndefined(acDetails.VAT_declaration_cadence__c)){
            component.find("vatDecl").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("vatDecl").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.VAT_declaration_extension_DFV__c) || $A.util.isUndefined(acDetails.VAT_declaration_extension_DFV__c)){
            component.find("vatDeclDFV").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("vatDeclDFV").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Sales_related_comments_for_ONB_and_CE__c) || $A.util.isUndefined(acDetails.Sales_related_comments_for_ONB_and_CE__c)){
            component.find("salerelcomment").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("salerelcomment").set("v.errors", null);
		}
		if($A.util.isEmpty(acDetails.Problems_with_old_Advisors_Providers__c) || $A.util.isUndefined(acDetails.Problems_with_old_Advisors_Providers__c)){
            component.find("probwithOldAdv").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("probwithOldAdv").set("v.errors", null);
		}
		if($A.util.isEmpty(component.get("v.employeeNumber")) || $A.util.isUndefined(component.get("v.employeeNumber"))){
            component.find("noofemp").set("v.errors", [{message: 'Field is Required'}]);
            isNotFilled = false;
        }else {
			component.find("noofemp").set("v.errors", null);
		}
		if($A.util.isEmpty(component.get("v.selectedLookUpRecord")) || $A.util.isUndefined(component.get("v.selectedLookUpRecord"))){
            component.find("firstZeitgCont").set("v.value", "Field is Required");
            isNotFilled = false;
        }else {
			component.find("firstZeitgCont").set("v.value", null);
		}
		if($A.util.isEmpty(component.get("v.selectedLookUpRecordForShareHolder")) || $A.util.isUndefined(component.get("v.selectedLookUpRecordForShareHolder"))){
            //alert('in lookup' + component.get("v.selectedLookUpRecordForShareHolder").Id);
			component.find("firstShareCont").set("v.value", "Field is Required");
            isNotFilled = false;
        }else {
			component.find("firstShareCont").set("v.errors", null);
		}
		if(isNotFilled == false){
			return;
		}
       component.set("v.showModalonSave", true);
   },
    
	closeModelPopup: function(component, event, helper) {
      
       component.set("v.showModal", false);
   },
   
   closeModelPopupSave: function(component, event, helper) {
      
       component.set("v.showModalonSave", false);
   },
	
    getContactRecordDetails: function(component, event, helper) {
        var recontIds = component.get("v.selectedLookUpRecord");
        helper.getFirstZGDetails(component, event, recontIds.Id);
    },
	
	getContactRecordDetailsShareHold: function(component, event, helper) {
        var recontId = component.get("v.selectedLookUpRecordForShareHolder");
		if(!$A.util.isUndefinedOrNull(recontId)){
			helper.getFirstShrHldDetails(component, event, recontId.Id);
		}
    },
    
    clearLookupVals: function(component, event, helper) {
        
        if($A.util.isUndefinedOrNull(component.get("v.selectedLookUpRecord").Id)){
            component.set("v.conDetailsFrstZGCon.FirstName", "");
            component.set("v.conDetailsFrstZGCon.LastName", "");
            component.set("v.conDetailsFrstZGCon.Salutation", "");
            component.set("v.conDetailsFrstZGCon.Email", "");
            component.set("v.conDetailsFrstZGCon.Phone", "");
            component.set("v.conDetailsFrstZGCon.Title", "");
            component.set("v.conDetailsFrstZGCon.Tone_of_address__c", "");
            component.set("v.conDetailsFrstZGCon.Language__c", "");
        }
        if($A.util.isUndefinedOrNull(component.get("v.selectedLookUpRecordForShareHolder").Id)){
            component.set("v.conDetailsShrHold.FirstName", "");
            component.set("v.conDetailsShrHold.LastName", "");
            component.set("v.conDetailsShrHold.Salutation", "");
            component.set("v.conDetailsShrHold.Email", "");
            component.set("v.conDetailsShrHold.Phone", "");
            component.set("v.conDetailsShrHold.Title", "");
            component.set("v.conDetailsShrHold.Tone_of_address__c", "");
            component.set("v.conDetailsShrHold.Language__c", "");
            
        }
		if($A.util.isUndefinedOrNull(component.get("v.selectedLookUpRecord").Id) && component.find("sameZGandShrHol").get("v.value") == 'Yes'){
			component.set("v.conDetailsFrstZGCon.FirstName", "");
            component.set("v.conDetailsFrstZGCon.LastName", "");
            component.set("v.conDetailsFrstZGCon.Salutation", "");
            component.set("v.conDetailsFrstZGCon.Email", "");
            component.set("v.conDetailsFrstZGCon.Phone", "");
            component.set("v.conDetailsFrstZGCon.Title", "");
            component.set("v.conDetailsFrstZGCon.Tone_of_address__c", "");
            component.set("v.conDetailsFrstZGCon.Language__c", "");
			component.set("v.selectedLookUpRecordForShareHolder", null);
			component.set("v.conDetailsShrHold.FirstName", "");
            component.set("v.conDetailsShrHold.LastName", "");
            component.set("v.conDetailsShrHold.Salutation", "");
            component.set("v.conDetailsShrHold.Email", "");
            component.set("v.conDetailsShrHold.Phone", "");
            component.set("v.conDetailsShrHold.Title", "");
            component.set("v.conDetailsShrHold.Tone_of_address__c", "");
            component.set("v.conDetailsShrHold.Language__c", "");
			component.find("sameZGandShrHol").set("v.value", "");
			
		}
		
    },
    
	saveAndClosedWonppty : function(component, event, helper) {
		component.set("v.IsSpinner",true);
		var oppRecordId = component.get("v.recordId");
		helper.callSaveOppContrl(component, event, oppRecordId);
	},
	
    saveAndHandoverToONB : function(component, event, helper) {

		component.set("v.IsSpinner",true);
		var oppRecordId = component.get("v.recordId");
		helper.callSaveandHandOver(component, event, oppRecordId);
		
	}
})