({
    fetchPickListVal: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfo"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
 
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
    
    
	showToast : function(component, event, type, title, message) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": type,
            "title": title,
            "message": message
        });
        toastEvent.fire();
    },
	
	
	getLeadPerFillDetails : function(component, event, rId) {
		var action = component.get("c.getLeadDetails");
        action.setParams({
            "leadId": rId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			suggestions.forEach(function(s) {
                component.set("v.leadName", s.Name),
                component.set("v.LeadDetails.FirstName", s.FirstName),
                component.set("v.LeadDetails.LastName", s.LastName),
                component.set("v.LeadDetails.Gender__c", s.Gender__c),
                component.set("v.LeadDetails.Tone_of_address__c", s.Tone_of_address__c),
                component.set("v.LeadDetails.Language__c", s.Language__c),
                component.set("v.LeadDetails.Demo_date__c", s.Demo_date__c),
                component.set("v.LeadDetails.Potential_dealbreaker__c", s.Potential_dealbreaker__c),
                component.set("v.LeadDetails.Personalitiy__c", s.Personalitiy__c),
				component.set("v.LeadDetails.LeadSource", s.LeadSource),
				component.set("v.LeadDetails.What_are_they_looking_for__c", s.What_are_they_looking_for__c),
				component.set("v.LeadDetails.Key_pain_point__c", s.Key_pain_point__c),
				component.set("v.LeadDetails.Weekly_hours_spent_on_bookkeeping__c", s.Weekly_hours_spent_on_bookkeeping__c),
				component.set("v.LeadDetails.Cash_journal_needed__c", s.Cash_journal_needed__c),
				component.set("v.LeadDetails.Cash_journal_kept_in_compliant_way__c", s.Cash_journal_kept_in_compliant_way__c),
				component.set("v.LeadDetails.Year_business_established__c", s.Year_business_established__c),
				component.set("v.LeadDetails.Legal_Form__c", s.Legal_Form__c),
				component.set("v.LeadDetails.Street", s.Street),
				component.set("v.LeadDetails.City", s.City),
				component.set("v.LeadDetails.PostalCode", s.PostalCode),
				component.set("v.LeadDetails.Name_cash_register__c", s.Name_cash_register__c),
				component.set("v.LeadDetails.Source_Revenues__c", s.Source_Revenues__c),
                component.set("v.LeadDetails.VAT_declaration_extension_DFV__c", s.VAT_declaration_extension_DFV__c),
				component.set("v.LeadDetails.Separate_private_business_bank_account__c", s.Separate_private_business_bank_account__c),
				component.set("v.LeadDetails.Name_Bank_business_bank_account__c", s.Name_Bank_business_bank_account__c),
				component.set("v.LeadDetails.AnnualRevenue", s.AnnualRevenue),
				component.set("v.employeeNumber", s.NumberOfEmployees),
				component.set("v.LeadDetails.Qualification_type__c", s.Qualification_type__c),
				component.set("v.LeadDetails.Status", s.Status),
				component.set("v.LeadDetails.Lost_Reason_Lead__c", s.Lost_Reason_Lead__c),
				component.set("v.LeadDetails.Zeitgold_Rejection_Reasons__c", s.Zeitgold_Rejection_Reasons__c),
				component.set("v.LeadDetails.Detailed_Lost_or_Rejection_Reason__c", s.Detailed_Lost_or_Rejection_Reason__c),
                component.set("v.LeadDetails.Next_Step__c", s.Next_Step__c),
                component.set("v.LeadDetails.FS_Next_Step_date__c", s.FS_Next_Step_date__c)
			});
		}
        
    });
                
		//$A.run(function() {
			$A.enqueueAction(action); 
		//});
	}
})