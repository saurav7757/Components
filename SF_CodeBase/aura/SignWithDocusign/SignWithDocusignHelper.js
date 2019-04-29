({
    doSignWithDocusign: function(component) {
        console.log('>> doSignWithDocusign');
                
        var oppID = component.get('v.recordId');                
        var action  = component.get("c.getSigningConfig");
        action.setParams({
            "oppID": component.get("v.recordId")
        });
        action.setCallback(this,function (response){
            var state = response.getState();
            console.log('doSignWithDocusign :: callback :: state: ' + state);
            if (state !== "SUCCESS") {
                console.log("doSignWithDocusign :: Failed to get docusign config. State: " + state);
                this.showToastMessage("Failed to trigger the signing process", false);                
                return;
            }
            
            var res = response.getReturnValue();
            console.log('doSignWithDocusign :: got signing config:' + res);
            if (res === null || res === undefined || res == '') {
               	console.log('doSignWithDocusign :: empty config returned from the server, no recipients');
               	this.showToastMessage("No contact roles with role shareholderN. No signing recipients added.", false);
            	this.goDocusign(oppID, 'LoadDefaultContacts~0', '');
                return;
            }            

            var recipients = res.map(x => 'Email~' + encodeURIComponent(x.Contact.Email) + ';LastName~' + x.Contact.LastName + ';Role~' + x.Role);
            var CRL = recipients.join(',');
            CRL += ',LoadDefaultContacts~0';
            
            var CCRM = 'Shareholder1~SH1;Shareholder2~SH2;Shareholder3~SH3;Shareholder4~SH4;';
            
            this.goDocusign(oppID, CRL, CCRM);
        });
        $A.enqueueAction(action);

        console.log('<< doSignWithDocusign');
	},
    goDocusign: function(sourceID, crl, ccrm) {
    	var urlEvent = $A.get("e.force:navigateToURL");
        // Not directly to the Docusign create envelope page because of CSRF protection
        // Our vf page will redirect the user to the Docusign vf page, passing the CSRF token along
        var url = '/apex/RedirectToDocusign?DSEID=0&SourceID=' + sourceID + '&CRL=' + crl + '&CCRM=' + ccrm;
        console.log('url: ' + url);
        urlEvent.setParams({
            "url": url,
            "isredirect": "true"
        });
        urlEvent.fire();
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