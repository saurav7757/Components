({
    doGenerateContracts : function(cmp) {
        console.log('>> doGenerateContracts');
        
        var oppID = cmp.get('v.recordId');
        console.log('doGenerateContracts :: oppID: ' + oppID);
        
        var action = cmp.get('c.generateContractsMan');
        action.setParams({oppID: oppID});
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('generate contracts callback :: state: ' + state);
            if (state !== "SUCCESS") {
                console.log("Failed to generate contracts: " + state);
                this.showToastMessage("Failed to generate contracts", false);
                
                // todo: get error message from server
                return;
            }
            
            this.showToastMessage("Contracts generated", true);
        });
        
        $A.enqueueAction(action);
        console.log('<< doGenerateContracts');
	},
	showToastMessage: function(text, isSuccess) {
       	var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": isSuccess ? "Success!" : "Error",
            "type": isSuccess ? "success" : "error",
            "message": text
        });
        toastEvent.fire();
    },
})