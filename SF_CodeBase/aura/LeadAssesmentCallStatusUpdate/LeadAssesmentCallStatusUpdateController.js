({
   doInit: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      
   }, 
    
   openModel: function(component, event, helper) {
      // for Display Model,set the "isOpen" attribute to "true"
      component.set("v.isOpen", true);
       //var label = component.get("v.recordId");
       //console.log('####'+label);
	  //component.set("v.RecId", label);
	  helper.fetchPickListVal(component, 'LeadSource', 'leadSource');
	  //helper.fetchPickListVal(component, 'Key_pain_point__c', 'selectGenre');
	  helper.fetchPickListVal(component, 'Key_pain_point__c', 'InputSelectMultiple');
	  helper.fetchPickListVal(component, 'Cash_journal_needed__c', 'cashJnr');
	  helper.fetchPickListVal(component, 'Cash_journal_kept_in_compliant_way__c', 'cashJnrComp');
	  helper.fetchPickListVal(component, 'Legal_Form__c', 'legalFrm');
	  helper.fetchPickListVal(component, 'Source_Revenues__c', 'InputSelectMultipleSrcRevs');
	  helper.fetchPickListVal(component, 'VAT_declaration_extension_DFV__c', 'vatDet');
	  helper.fetchPickListVal(component, 'Separate_private_business_bank_account__c', 'sprBank');
	  helper.fetchPickListVal(component, 'Qualification_type__c', 'qualType');
	  helper.fetchPickListVal(component, 'Status', 'ldStatus');
	  helper.fetchPickListVal(component, 'Gender__c', 'gender');
	  helper.fetchPickListVal(component, 'Tone_of_address__c', 'toneAddr');
	  helper.fetchPickListVal(component, 'Language__c', 'langSel');
	  helper.fetchPickListVal(component, 'Personalitiy__c', 'perType');
	  //if(component.get("v.LeadDetails.Status") == 'Closed Lost'){
		//helper.fetchPickListVal(component, 'Lost_Reason_Lead__c', 'lostRsn');
	  //}
	  //alert('gfgfgf' + component.get("v.LeadDetails.Status"));
	  //if(component.get("v.LeadDetails.Status") == 'Rejected'){
		//helper.fetchPickListVal(component, 'Zeitgold_Rejection_Reasons__c', 'InputSelectMultiplerejRsns');
	  //}
	  var recIdLead = component.get("v.recordId");
	  helper.getLeadPerFillDetails(component, event, recIdLead);
	  //$A.enqueueAction(component.get('c.renderOtherLeadDetails'));
	  //$A.enqueueAction(component.get('c.handleGenreChangeForSrc'));
	  //$A.enqueueAction(component.get('c.handleGenreChangeForRejRsns'));
   },
 
   closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
	  component.set("v.isRender", false);
   },
   
	handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.LeadDetails.Key_pain_point__c", selectedValues);
    },
	
	handleGenreChangeForSrc: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.LeadDetails.Source_Revenues__c", selectedValues);
    },
	
	
	renderOtherLeadDetails: function (component, event, helper) {
		//alert('$$$123' + component.get("v.LeadDetails.Status"));
		//alert('$$$1234' + !v.LeadDetails.Status);
		component.set("v.isRender", true);
		if(component.get("v.LeadDetails.Status") == 'Closed Lost'){
			helper.fetchPickListVal(component, 'Lost_Reason_Lead__c', 'lostRsn');
		}
		if(component.get("v.LeadDetails.Status") == 'Rejected'){
			helper.fetchPickListVal(component, 'Zeitgold_Rejection_Reasons__c', 'InputSelectMultiplerejRsns');
		}
    },
	
	handleGenreChangeForRejRsns: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
         
        //Update the Selected Values  
        component.set("v.LeadDetails.Zeitgold_Rejection_Reasons__c", selectedValues);
    },
	
   updateLead: function(component, event, helper) {
      
       var LeadDetails = component.get("v.LeadDetails");
	  //Calling the Apex Function
        var action = component.get("c.updateRecord");
        
		//Validation
        if($A.util.isEmpty(component.get("v.myNotesTitle")) || $A.util.isUndefined(component.get("v.myNotesTitle"))){
            component.find("titleNote").set("v.errors", [{message: 'Please enter a title for your note'}]);
            return;
        }
		
        //Setting the Apex Parameter
        action.setParams({
            leadRecDetails : LeadDetails,
			leadRecId : component.get("v.recordId"),
			noEmployee : component.get("v.employeeNumber"),
			ldNotes : component.get("v.myNotes"),
			ldTitle : component.get("v.myNotesTitle")
        });
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            
            //check if result is successfull
            if(state == "SUCCESS"){
                helper.showToast(component, event, "success", "Success!", "Lead Successfully Updated.");
                setTimeout(function(){ location.reload(); }, 400);
                //alert('Record is Updated Successfully');
            } else if(state == "ERROR"){
                helper.showToast(component, event, "error", "Error!", "Lead Update failed.Please try again.");
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
	  
	  
      //component.set("v.isOpen", false);
   },
})