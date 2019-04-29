({
	doInit : function(component, event, helper) {
		
	},
    
    openModel : function(component, event, helper) {
		component.set("v.isOpen", true);
	},
    getUserRecordDetails : function(component, event, helper) {
		//component.set("v.isOpen", true);
		console.log('$$$$$' +component.get("v.selectedLookUpRecord").Id);
	},
    clearLookupVals : function(component, event, helper) {
		//component.set("v.isOpen", true);
		console.log('$$$$$' +component.get("v.selectedLookUpRecord").Id);
	},
    
    closeModel: function(component, event, helper) {
      // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
      component.set("v.isOpen", false);
	  //component.set("v.isRender", false);
   },
    
    getoptionsValue : function(component, event, helper) {
		
        var getWhichBtn = event.getSource().get("v.value");
        if(getWhichBtn == 'Queue'){
            component.set("v.isUser", false);
        	component.set("v.isQueue", true);
        } else if(getWhichBtn == 'User'){
            component.set("v.isUser", true);
        	component.set("v.isQueue", false);
            }
		console.log('$$$$$4567' +getWhichBtn);
	},
    
    saveQueueOrUser : function(component, event, helper) {
		var caseRecordId = component.get("v.recordId");
        var selectedUserorQueueId = component.get("v.selectedLookUpRecord").Id;
        component.set("v.IsSpinner",true);
        helper.updateCaseOwnership(component, event, caseRecordId, selectedUserorQueueId);
	},
    
    takeOwnership : function(component, event, helper) {
		var caseRecordId = component.get("v.recordId");
        component.set("v.IsSpinner",true);
		helper.updateCaseOwner(component, event, caseRecordId);
	}
})