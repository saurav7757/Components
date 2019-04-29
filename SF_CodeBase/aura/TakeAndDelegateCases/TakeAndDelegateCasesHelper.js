({
	updateCaseOwner : function(component, event, csRecordId) {
	  //Calling the Apex Function
        var action = component.get("c.takeOwnershipnCase");
        //Setting the Apex Parameter
        action.setParams({
            csRecId : csRecordId
		});
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            var result = a.getReturnValue();
			component.set("v.IsSpinner",false);
			
            //check if result is successfull
            if(state == "SUCCESS" && !$A.util.isUndefinedOrNull(result) && result == true){
                this.showToast(component, event, "success", "Successfully taken the Ownership of the Case!!", "Success");
				setTimeout(function(){ location.reload(); }, 1300);
                //alert('Record is Updated Successfully');
            } else if(state == "SUCCESS" && !$A.util.isUndefinedOrNull(result) && result == false){
				this.showToast(component, event, "error", "Error!", "Ownership update failed. Please try again or contact your administrator.");
			}else if(state == "ERROR"){
                this.showToast(component, event, "error", "Error!", "Ownership update failed. Please try again or contact your administrator.");
            }
        });
        
		//adds the server-side action to the queue        
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
    
    updateCaseOwnership : function(component, event, csRecordId, selUserorQueueId) {
	  //Calling the Apex Function
        var action = component.get("c.takeOwnershipnCase");
        //Setting the Apex Parameter
        action.setParams({
            csRecId : csRecordId,
            usOrQueueId : selUserorQueueId
		});
        
        //Setting the Callback
        action.setCallback(this,function(a){
            //get the response state
            var state = a.getState();
            var result = a.getReturnValue();
			component.set("v.IsSpinner",false);
			
            //check if result is successfull
            if(state == "SUCCESS" && !$A.util.isUndefinedOrNull(result) && result == true){
                this.showToast(component, event, "success", "Successfully delegated the Case!!", "Success");
				setTimeout(function(){ location.reload(); }, 1300);
                //alert('Record is Updated Successfully');
            } else if(state == "SUCCESS" && !$A.util.isUndefinedOrNull(result) && result == false){
				this.showToast(component, event, "error", "Error!", "Case Delegation failed. Please try again or contact your administrator.");
			}else if(state == "ERROR"){
                this.showToast(component, event, "error", "Error!", "Case Delegation failed. Please try again or contact your administrator.");
            }
        });
        
		//adds the server-side action to the queue        
        $A.enqueueAction(action);
	}
})