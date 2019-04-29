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
    
	fetchPickListValCont: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfoCont"),
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
	
	fetchPickListValAcc: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfoAcct"),
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
    
    
	getFirstZGDetails : function(component, event, rId) {
		component.set("v.conDetailsFrstZGCon.FirstName", "");
        component.set("v.conDetailsFrstZGCon.LastName", "");
        component.set("v.conDetailsFrstZGCon.Salutation", "");
        component.set("v.conDetailsFrstZGCon.Email", "");
        component.set("v.conDetailsFrstZGCon.Phone", "");
        component.set("v.conDetailsFrstZGCon.Title", "");
        component.set("v.conDetailsFrstZGCon.Tone_of_address__c", "");
        component.set("v.conDetailsFrstZGCon.Language__c", "");
        var action = component.get("c.getZGDetails");
        action.setParams({
            "contID": rId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			suggestions.forEach(function(s) {
                component.set("v.conDetailsFrstZGCon.FirstName", s.FirstName),
                component.set("v.conDetailsFrstZGCon.LastName", s.LastName),
                component.set("v.conDetailsFrstZGCon.Salutation", s.Salutation),
                component.set("v.conDetailsFrstZGCon.Email", s.Email),
                component.set("v.conDetailsFrstZGCon.Phone", s.Phone),
                component.set("v.conDetailsFrstZGCon.Title", s.Title),
                component.set("v.conDetailsFrstZGCon.Tone_of_address__c", s.Tone_of_address__c),
                component.set("v.conDetailsFrstZGCon.Language__c", s.Language__c )
			});
		}
        
    });
        $A.enqueueAction(action); 
	},
    
    getPrefilledZGDetails : function(component, event, opptId) {
		
		component.set("v.conDetailsFrstZGCon.FirstName", "");
        component.set("v.conDetailsFrstZGCon.LastName", "");
        component.set("v.conDetailsFrstZGCon.Salutation", "");
        component.set("v.conDetailsFrstZGCon.Email", "");
        component.set("v.conDetailsFrstZGCon.Phone", "");
        component.set("v.conDetailsFrstZGCon.Title", "");
        component.set("v.conDetailsFrstZGCon.Tone_of_address__c", "");
        component.set("v.conDetailsFrstZGCon.Language__c", "");
		var action = component.get("c.getFilledZGDetails");
        action.setParams({
            "optyID": opptId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			console.log('$$$$$$123' + suggestions);
			if(!$A.util.isUndefinedOrNull(suggestions)){
			suggestions.forEach(function(s) {
				console.log('$$$$$$' + s);
                //component.set("v.selectedLookUpRecord", s.First_ZG_Contact__c),
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.FirstName)){
					component.set("v.conDetailsFrstZGCon.FirstName", s.Account.First_ZG_Contact__r.FirstName);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.LastName)){
					component.set("v.conDetailsFrstZGCon.LastName", s.Account.First_ZG_Contact__r.LastName);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Salutation)) {
					component.set("v.conDetailsFrstZGCon.Salutation", s.Account.First_ZG_Contact__r.Salutation);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Email)) {
					component.set("v.conDetailsFrstZGCon.Email", s.Account.First_ZG_Contact__r.Email);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Phone)) {
					component.set("v.conDetailsFrstZGCon.Phone", s.Account.First_ZG_Contact__r.Phone);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Title)) {
					component.set("v.conDetailsFrstZGCon.Title", s.Account.First_ZG_Contact__r.Title);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Tone_of_address__c)) {
					component.set("v.conDetailsFrstZGCon.Tone_of_address__c", s.Account.First_ZG_Contact__r.Tone_of_address__c);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_ZG_Contact__r.Language__c)) {
					component.set("v.conDetailsFrstZGCon.Language__c", s.Account.First_ZG_Contact__r.Language__c);
				}
			});
		}
		}
        //alert('hfhfhfhfhfhfhf' + component.get("v.selectedLookUpRecord"));
    });
        $A.enqueueAction(action);
        
        var action = component.get("c.getFillZGDetails");
        action.setParams({
            "optyID": opptId
        });
        action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			//suggestions.forEach(function(s) {
                component.set("v.selectedLookUpRecord", suggestions)
                
			//});
		}
        //alert('hfhfhfhfhfhfhfsssss' + component.get("v.selectedLookUpRecord"));
        //alert('hfhfhfhfhfhfhfsssss111' + component.get("v.selectedLookUpRecord").Id);    
    });
       $A.enqueueAction(action); 
	},
	
	getPrefilledParentAccDetails : function(component, event, oppttId) {
		var action = component.get("c.getParentAccountDetails");
        action.setParams({
            "opID": oppttId
        });
        action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			//suggestions.forEach(function(s) {
                component.set("v.selectedLookUpRecordForParentAcc", suggestions)
		}    
    });
       $A.enqueueAction(action); 
	},
	
	getFirstShrHldDetails : function(component, event, rId) {
		component.set("v.conDetailsShrHold.FirstName", "");
        component.set("v.conDetailsShrHold.LastName", "");
        component.set("v.conDetailsShrHold.Salutation", "");
        component.set("v.conDetailsShrHold.Email", "");
        component.set("v.conDetailsShrHold.Phone", "");
        component.set("v.conDetailsShrHold.Title", "");
        component.set("v.conDetailsShrHold.Tone_of_address__c", "");
        component.set("v.conDetailsShrHold.Language__c", "");
        var action = component.get("c.getShrHoldDetails");
        action.setParams({
            "contshrID": rId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			suggestions.forEach(function(s) {
                component.set("v.conDetailsShrHold.FirstName", s.FirstName),
                component.set("v.conDetailsShrHold.LastName", s.LastName),
                component.set("v.conDetailsShrHold.Salutation", s.Salutation),
                component.set("v.conDetailsShrHold.Email", s.Email),
                component.set("v.conDetailsShrHold.Phone", s.Phone),
                component.set("v.conDetailsShrHold.Title", s.Title),
                component.set("v.conDetailsShrHold.Tone_of_address__c", s.Tone_of_address__c),
                component.set("v.conDetailsShrHold.Language__c", s.Language__c )
			});
		}
        
    });
        $A.enqueueAction(action); 
	},
	
	getPrefilledShrHoldDetails : function(component, event, opptId) {
		
        component.set("v.selectedLookUpRecordForShareHolder", {});
        
		component.set("v.conDetailsShrHold.FirstName", "");
        component.set("v.conDetailsShrHold.LastName", "");
        component.set("v.conDetailsShrHold.Salutation", "");
        component.set("v.conDetailsShrHold.Email", "");
        component.set("v.conDetailsShrHold.Phone", "");
        component.set("v.conDetailsShrHold.Title", "");
        component.set("v.conDetailsShrHold.Tone_of_address__c", "");
        component.set("v.conDetailsShrHold.Language__c", "");
		var action = component.get("c.getFilledShrHolDetails");
        action.setParams({
            "opptyID": opptId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			if(!$A.util.isUndefinedOrNull(suggestions)){
			suggestions.forEach(function(s) {
                //component.set("v.selectedLookUpRecord", s.First_ZG_Contact__c),
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.FirstName)) {
					component.set("v.conDetailsShrHold.FirstName", s.Account.First_Shareholder__r.FirstName);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.LastName)) {
					component.set("v.conDetailsShrHold.LastName", s.Account.First_Shareholder__r.LastName);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Salutation)){
					component.set("v.conDetailsShrHold.Salutation", s.Account.First_Shareholder__r.Salutation);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Email)){
					component.set("v.conDetailsShrHold.Email", s.Account.First_Shareholder__r.Email);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Phone)){
					component.set("v.conDetailsShrHold.Phone", s.Account.First_Shareholder__r.Phone);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Title)){
					component.set("v.conDetailsShrHold.Title", s.Account.First_Shareholder__r.Title);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Tone_of_address__c)){
					component.set("v.conDetailsShrHold.Tone_of_address__c", s.Account.First_Shareholder__r.Tone_of_address__c);
				}
				if(!$A.util.isUndefinedOrNull(s.Account.First_Shareholder__r.Language__c)){
					component.set("v.conDetailsShrHold.Language__c", s.Account.First_Shareholder__r.Language__c);
				}
			});
		}
		}
        //alert('hfhfhfhfhfhfhf' + component.get("v.selectedLookUpRecord"));
    });
        $A.enqueueAction(action);
        
        var action = component.get("c.getFillShrHolDetails");
        action.setParams({
            "opptyID": opptId
        });
        action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			//suggestions.forEach(function(s) {
                component.set("v.selectedLookUpRecordForShareHolder", suggestions)
                
			//});
		}
        //alert('hfhfhfhfhfhfhfsssss111' + component.get("v.selectedLookUpRecord"));
        //alert('hfhfhfhfhfhfhfsssss111' + component.get("v.selectedLookUpRecord").Id);    
    });
       $A.enqueueAction(action); 
	},
	
    setSameZGandShrHolder : function(component, event){
        
        
        if($A.util.isUndefinedOrNull(component.get("v.selectedLookUpRecord"))){
            component.set("v.selectedLookUpRecordForShareHolder", null);
        }else{
    	component.set("v.selectedLookUpRecordForShareHolder", component.get("v.selectedLookUpRecord"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.FirstName"))){
    	component.set("v.conDetailsShrHold.FirstName", null);
        }else{
    	component.set("v.conDetailsShrHold.FirstName", component.get("v.conDetailsFrstZGCon.FirstName"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.LastName"))){
        component.set("v.conDetailsShrHold.LastName", null);
        }else{
    	component.set("v.conDetailsShrHold.LastName", component.get("v.conDetailsFrstZGCon.LastName"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Salutation"))){
		component.set("v.conDetailsShrHold.Salutation", null);
        } else{
    	component.set("v.conDetailsShrHold.Salutation", component.get("v.conDetailsFrstZGCon.Salutation"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Email"))){
		component.set("v.conDetailsShrHold.Email", null);
        }else{
    	component.set("v.conDetailsShrHold.Email", component.get("v.conDetailsFrstZGCon.Email"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Phone"))){
		component.set("v.conDetailsShrHold.Phone", null);
        }else{
    	component.set("v.conDetailsShrHold.Phone", component.get("v.conDetailsFrstZGCon.Phone"));
        }
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Title"))){
		component.set("v.conDetailsShrHold.Title", null);
        } else{
    	component.set("v.conDetailsShrHold.Title", component.get("v.conDetailsFrstZGCon.Title"));
        } 
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Tone_of_address__c"))){
		component.set("v.conDetailsShrHold.Tone_of_address__c", null);
        } else{
    	component.set("v.conDetailsShrHold.Tone_of_address__c", component.get("v.conDetailsFrstZGCon.Tone_of_address__c"));
        } 
        
        if($A.util.isUndefinedOrNull(component.get("v.conDetailsFrstZGCon.Language__c"))){
		component.set("v.conDetailsShrHold.Language__c", null);
        } else{
    	component.set("v.conDetailsShrHold.Language__c", component.get("v.conDetailsFrstZGCon.Language__c"));
        } 
	},
	
	getOppPerFillDetails : function(component, event, opprecId) {
		var action = component.get("c.getOppFilDetails");
        action.setParams({
            "opId": opprecId
        });
		 action.setCallback(this, function(a) {
        
		if (a.getState() == "SUCCESS"){
			var suggestions = a.getReturnValue();
			suggestions.forEach(function(s) {
				component.set("v.AccrecordId", s.AccountId),
                component.set("v.accDetails.Go_Live_Date__c", s.Account.Go_Live_Date__c),
                //component.set("v.accDetails.Onboarding_Process__c", s.Account.Onboarding_Process__c),
                component.set("v.accDetails.Is_ZG_First_Contact_and_Shareholder_same__c", s.Account.Is_ZG_First_Contact_and_Shareholder_same__c),
                component.set("v.accDetails.Company_Legal_Name__c", s.Account.Company_Legal_Name__c),
                component.set("v.accDetails.Name", s.Account.Name),
                component.set("v.accDetails.Industry", s.Account.Industry),
                component.set("v.accDetails.Industry_Type__c", s.Account.Industry_Type__c),
                component.set("v.accDetails.BillingStreet", s.Account.BillingStreet),
				component.set("v.accDetails.BillingCountry", s.Account.BillingCountry),
				component.set("v.accDetails.Nature_Purpose_of_business__c", s.Account.Nature_Purpose_of_business__c),
				component.set("v.accDetails.BillingCity", s.Account.BillingCity),
				component.set("v.accDetails.BillingPostalCode", s.Account.BillingPostalCode),
				component.set("v.OppDetails.MRR_Zeitgold__c", s.MRR_Zeitgold__c),
				component.set("v.OppDetails.MRR_Tax_Advisor__c", s.MRR_Tax_Advisor__c),
				component.set("v.OppDetails.Special_Initial_MRR_w_o_Tax_Advisor_F__c", s.Special_Initial_MRR_w_o_Tax_Advisor_F__c),
				component.set("v.OppDetails.Special_Initial_MRR_Valid_for_how_many_m__c", s.Special_Initial_MRR_Valid_for_how_many_m__c),
				component.set("v.OppDetails.Total_monthly_Tax_advisor_fee__c", s.Total_monthly_Tax_advisor_fee__c),
				component.set("v.OppDetails.Total_annual_tax_advisor_fee__c", s.Total_annual_tax_advisor_fee__c),
				component.set("v.OppDetails.ARR_Tax_Advisor_Year_End_Statement__c", s.ARR_Tax_Advisor_Year_End_Statement__c),
				component.set("v.accDetails.Link_to_sales_offer__c", s.Account.Link_to_sales_offer__c),
				component.set("v.OppDetails.Special_offer_Other_if_applicable__c", s.Special_offer_Other_if_applicable__c),
				component.set("v.accDetails.Accounting_Start_Date__c", s.Account.Accounting_Start_Date__c),
				component.set("v.OppDetails.Special_offer_PIO_if_applicable__c", s.Special_offer_PIO_if_applicable__c),
				component.set("v.accDetails.AnnualRevenue", s.Account.AnnualRevenue),
				component.set("v.employeeNumber", s.Account.NumberOfEmployees),
				component.set("v.accDetails.Payroll_Start_Date__c", s.Account.Payroll_Start_Date__c),
				component.set("v.accDetails.Name_cash_register__c", s.Account.Name_cash_register__c),
				component.set("v.accDetails.CEP_Migration_necessary__c", s.Account.CEP_Migration_necessary__c),
				component.set("v.accDetails.VAT_declaration_cadence__c", s.Account.VAT_declaration_cadence__c),
				component.set("v.accDetails.VAT_declaration_extension_DFV__c", s.Account.VAT_declaration_extension_DFV__c),
				component.set("v.accDetails.Sales_related_comments_for_ONB_and_CE__c", s.Account.Sales_related_comments_for_ONB_and_CE__c),
				component.set("v.accDetails.Problems_with_old_Advisors_Providers__c", s.Account.Problems_with_old_Advisors_Providers__c)
                
			});
		}
        
    });
                
		//$A.run(function() {
			$A.enqueueAction(action); 
        	//$A.enqueueAction(component.get('c.onSingleSelectChange'));
		//});
	},
	
	callSaveOppContrl : function(component, event, oppRecId){
		var OppRecordDetails = component.get("v.OppDetails");
		var AccRecordDetails = component.get("v.accDetails");
		var ConFrstZGRecordDetails = component.get("v.conDetailsFrstZGCon");
		var ConFrstShrHolRecordDetails = component.get("v.conDetailsShrHold");
	  //Calling the Apex Function
        var action = component.get("c.updateRecordWithoutHandover");
        
		
        //Setting the Apex Parameter
        action.setParams({
            oppRecDetails : OppRecordDetails,
			accDet : AccRecordDetails,
			accId : component.get("v.AccrecordId"),
			opRecId : oppRecId,
			firstZgCont : component.get("v.selectedLookUpRecord").Id,
			firstShareHol : component.get("v.selectedLookUpRecordForShareHolder").Id,
			conFrtZG : ConFrstZGRecordDetails,
			conFrtShrHol : ConFrstShrHolRecordDetails,
			noOfEmp : component.get("v.employeeNumber")
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            //var result = a.getReturnValue();
			component.set("v.IsSpinner",false);
            //check if result is successfull
            if(state == "SUCCESS"){
                this.showToast(component, event, "success", "Success!", "Opportunity is Successfully updated and maked as Closed Won!!");
                setTimeout(function(){ location.reload(); }, 600);
                //alert('Record is Updated Successfully');
            } else if(state == "ERROR"){
                this.showToast(component, event, "error", "Error!", "Opportunity Update failed. Please try again or contact your administrator.");
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
	  
	  
      //component.set("v.isOpen", false);
		
	},
	
	callSaveandHandOver: function(component, event, oppRecId) {
		var OppRecordDetails = component.get("v.OppDetails");
		var AccRecordDetails = component.get("v.accDetails");
		var ConFrstZGRecordDetails = component.get("v.conDetailsFrstZGCon");
		var ConFrstShrHolRecordDetails = component.get("v.conDetailsShrHold");
		var parAccDetails;
		if(!$A.util.isUndefinedOrNull(component.get("v.selectedLookUpRecordForParentAcc"))){
			parAccDetails = component.get("v.selectedLookUpRecordForParentAcc").Id;
		}
	  //Calling the Apex Function
        var action = component.get("c.updateRecord");
        
		
        //Setting the Apex Parameter
        action.setParams({
            oppRecDetails : OppRecordDetails,
			accDet : AccRecordDetails,
			accId : component.get("v.AccrecordId"),
			opRecId : oppRecId,
			firstZgCont : component.get("v.selectedLookUpRecord").Id,
			firstShareHol : component.get("v.selectedLookUpRecordForShareHolder").Id,
			conFrtZG : ConFrstZGRecordDetails,
			conFrtShrHol : ConFrstShrHolRecordDetails,
			noOfEmp : component.get("v.employeeNumber"),
			parentAccId : parAccDetails
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            var result = a.getReturnValue();
			component.set("v.IsSpinner",false);
			
            //check if result is successfull
            if(state == "SUCCESS" && !$A.util.isUndefinedOrNull(result)){
                this.showToast(component, event, "success", "Successfully Closed Won and Handed Over to Onboarding!!. Onboarding Manger assigned is : ", result);
				setTimeout(function(){ location.reload(); }, 5000);
                //alert('Record is Updated Successfully');
            } else if(state == "SUCCESS" && $A.util.isUndefinedOrNull(result)){
				this.showToast(component, event, "error", "Error!", "Opportunity Update and HandOver failed. Please try again or contact your administrator.");
			}else if(state == "ERROR"){
                this.showToast(component, event, "error", "Error!", "Opportunity Update and HandOver failed. Please try again or contact your administrator.");
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
	  
	  
      //component.set("v.isOpen", false);
	}
})