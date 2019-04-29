/*
*Name       : CaseTriggerHandler
*Description  : CaseTriggerHandler Handler Class is to handle the logic/methods for Case.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 



public class CaseTriggerHandler {
     
     public static void validateFieldsMsg(List<Case> caseList, Map<Id,Case> mapOldCase){
        
        String queueId;
        String userIdList;
        String queueIdNew;
        String userIdListNew;
        String grpName;
        String grpNameNew;
        String uRoleId = UserInfo.getUserRoleId();
        String usrId = UserInfo.getUserId();
        String profId = UserInfo.getProfileId();
        String userRoleName;
        String profName;
        Id ownerRoleId;
        String ownerRoleName;
        Id ownerRoleIdQueue;
        
        
        for(Case cs : caseList){
            Case oldCase = mapOldCase.get(cs.ID);
            if((cs.Status != oldCase.Status) && oldCase.Status == 'Active Case Split' && cs.Create_Case_Split__c == true) {
                cs.addError('Cannot change the status in Active Case Split.');
                return;
            }
        }
        
        for(Case cs:caseList){
        if (cs.OwnerID != mapOldCase.get(cs.Id).OwnerID && (mapOldCase.get(cs.Id).OwnerID.getsobjecttype() == User.sobjecttype)) {
            /*Code if Owner is User*/
            userIdList = mapOldCase.get(cs.Id).OwnerID;
            if(cs.OwnerId.getsobjecttype() == User.sobjecttype){
                ownerRoleId = cs.OwnerId;
            } else {
                ownerRoleIdQueue = cs.OwnerId;
            }
            system.debug('###12356700900000' + ownerRoleId);
        }
        else if(cs.OwnerID != mapOldCase.get(cs.Id).OwnerID){
            /*Code if Owner is Queue*/
            queueId = mapOldCase.get(cs.Id).OwnerID;
        }
        
        if (cs.OwnerID == mapOldCase.get(cs.Id).OwnerID && cs.OwnerID.getsobjecttype() == User.sobjecttype) {
            /*Code if Owner is User*/
            userIdListNew = cs.OwnerID;
        }
        else if(cs.OwnerID == mapOldCase.get(cs.Id).OwnerID){
            /*Code if Owner is Queue*/
            queueIdNew = cs.OwnerID;
            system.debug('###123' + queueIdNew);
        }
        
    }
        if(String.isNotEmpty(queueId)){
            Group gp = [SELECT Id, Name FROM Group WHERE Id =: queueId];
            if(String.isNotEmpty(gp.Name)){
                grpName = gp.Name;
            }
        }
    
        if(String.isNotEmpty(queueIdNew)){
            Group gp = [SELECT Id, Name FROM Group WHERE Id =: queueIdNew];
            if(String.isNotEmpty(gp.Name)){
                grpNameNew = gp.Name;
            }
        }
        
        if(String.isNotEmpty(uRoleId)){
            UserRole usr = [SELECT Id, Name, DeveloperName FROM UserRole WHERE Id =: uRoleId];
            if(String.isNotEmpty(usr.Name)){
                userRoleName = usr.Name;
            }
        }
        
        if(String.isNotEmpty(profId)){
            Profile pfr = [SELECT Id, Name FROM Profile WHERE Id =: profId];
            if(String.isNotEmpty(pfr.Name)){
                profName = pfr.Name;
            }
        }
        
        if(String.isNotEmpty(ownerRoleId) && String.isEmpty(ownerRoleIdQueue)){
            User pfrUser = [SELECT Id, Name, UserRole.Name FROM User WHERE Id =: ownerRoleId];
            if(String.isNotEmpty(pfrUser.UserRole.Name)){
                ownerRoleName = pfrUser.UserRole.Name;
            }
        } else if(String.isEmpty(ownerRoleId) && String.isNotEmpty(ownerRoleIdQueue)){
            Group gpNam = [SELECT Id, Name FROM Group WHERE Id =: ownerRoleIdQueue];
            if(String.isNotEmpty(gpNam.Name)){
                ownerRoleName = gpNam.Name;
            }
        }
    
        for(Case cs:caseList){
            if((String.isNotEmpty(userRoleName) && String.isNotEmpty(grpName) && String.isNotEmpty(profName) && userRoleName != grpName && !userRoleName.equals(grpName.split(' ')[0]+ ' ' +'DS') && !userRoleName.equals(grpName.split(' ')[0]+ ' ' +'TA') && profName != 'System Administrator' &&  profName != 'Onboarding' && userRoleName != 'General Service CCA' && cs.Onboarding_CCA_Status__c == null && cs.Onboarding_DS_Status__c == null && cs.Accounting_CCA_Status__c == null && cs.Accounting_DS_Status__c == null && cs.Digitalization_CCA_Status__c == null && cs.Digitalization_DS_Status__c == null && cs.Payments_CCA_Status__c == null && cs.Payments_DS_Status__c == null && cs.Payroll_CCA_Status__c == null && cs.Payroll_DS_Status__c == null && cs.Support_CCA_Status__c == null && cs.Support_DS_Status__c == null && (cs.Status == mapOldCase.get(cs.Id).Status)) || (String.isNotEmpty(userRoleName) && String.isNotEmpty(grpNameNew) && String.isNotEmpty(profName) && userRoleName != grpNameNew && !userRoleName.equals(grpNameNew.split(' ')[0]+ ' ' +'DS') && !userRoleName.equals(grpNameNew.split(' ')[0]+ ' ' +'TA') && profName != 'System Administrator' &&  profName != 'Onboarding' && userRoleName != 'General Service CCA' && cs.Onboarding_CCA_Status__c == null && cs.Onboarding_DS_Status__c == null && cs.Accounting_CCA_Status__c == null && cs.Accounting_DS_Status__c == null && cs.Digitalization_CCA_Status__c == null && cs.Digitalization_DS_Status__c == null && cs.Payments_CCA_Status__c == null && cs.Payments_DS_Status__c == null && cs.Payroll_CCA_Status__c == null && cs.Payroll_DS_Status__c == null && cs.Support_CCA_Status__c == null && cs.Support_DS_Status__c == null && (cs.Status == mapOldCase.get(cs.Id).Status)) || (String.isEmpty(userRoleName) && String.isNotEmpty(grpNameNew) && String.isNotEmpty(profName) && userRoleName != grpNameNew && !userRoleName.equals(grpNameNew.split(' ')[0]+ ' ' +'DS') && !userRoleName.equals(grpNameNew.split(' ')[0]+ ' ' +'TA') && profName != 'System Administrator' &&  profName != 'Onboarding' && userRoleName != 'General Service CCA' && cs.Onboarding_CCA_Status__c == null && cs.Onboarding_DS_Status__c == null && cs.Accounting_CCA_Status__c == null && cs.Accounting_DS_Status__c == null && cs.Digitalization_CCA_Status__c == null && cs.Digitalization_DS_Status__c == null && cs.Payments_CCA_Status__c == null && cs.Payments_DS_Status__c == null && cs.Payroll_CCA_Status__c == null && cs.Payroll_DS_Status__c == null && cs.Support_CCA_Status__c == null && cs.Support_DS_Status__c == null && (cs.Status == mapOldCase.get(cs.Id).Status))){
                system.debug('###1235' + userRoleName );
                system.debug('###123567' + grpName );
                system.debug('###1235670014789' + grpNameNew);
                system.debug('###123567001478900' + userRoleName);
                cs.AddError('Looks like you don\'t have the permissions to update/create it.');
                return;
            }
            if(!Test.isRunningTest() && (String.isNotEmpty(userIdList) && String.isNotEmpty(usrId) && String.isNotEmpty(profName) && userIdList != usrId && String.isNotEmpty(ownerRoleName) && userRoleName != ownerRoleName && !userRoleName.equals(ownerRoleName.split(' ')[0]+ ' ' +'DS') && !userRoleName.equals(ownerRoleName.split(' ')[0]+ ' ' +'TA') && profName != 'System Administrator' &&  profName != 'Onboarding' && userRoleName != 'General Service CCA' && cs.Onboarding_CCA_Status__c == null && cs.Onboarding_DS_Status__c == null && cs.Accounting_CCA_Status__c == null && cs.Accounting_DS_Status__c == null && cs.Digitalization_CCA_Status__c == null && cs.Digitalization_DS_Status__c == null && cs.Payments_CCA_Status__c == null && cs.Payments_DS_Status__c == null && cs.Payroll_CCA_Status__c == null && cs.Payroll_DS_Status__c == null && cs.Support_CCA_Status__c == null && cs.Support_DS_Status__c == null && (cs.Status == mapOldCase.get(cs.Id).Status)) || (String.isNotEmpty(userIdListNew) && String.isNotEmpty(usrId) && String.isNotEmpty(profName) && String.isNotEmpty(ownerRoleName) && userIdListNew != usrId && userRoleName != ownerRoleName && !userRoleName.equals(ownerRoleName.split(' ')[0]+ ' ' +'DS') && !userRoleName.equals(ownerRoleName.split(' ')[0]+ ' ' +'TA') && profName != 'System Administrator' &&  profName != 'Onboarding' && userRoleName != 'General Service CCA' && cs.Onboarding_CCA_Status__c == null && cs.Onboarding_DS_Status__c == null && cs.Accounting_CCA_Status__c == null && cs.Accounting_DS_Status__c == null && cs.Digitalization_CCA_Status__c == null && cs.Digitalization_DS_Status__c == null && cs.Payments_CCA_Status__c == null && cs.Payments_DS_Status__c == null && cs.Payroll_CCA_Status__c == null && cs.Payroll_DS_Status__c == null && cs.Support_CCA_Status__c == null && cs.Support_DS_Status__c == null && (cs.Status == mapOldCase.get(cs.Id).Status))){
                system.debug('###123500' + userRoleName );
                system.debug('###12356700' + grpName );
                system.debug('###12356700111' + ownerRoleName);
                cs.AddError('Looks like you don\'t have the permissions to update/create it.');
                return;
            }
            
            if((cs.OwnerId != usrId) && ((cs.Priority != mapOldCase.get(cs.Id).Priority) || (cs.ContactId != mapOldCase.get(cs.Id).ContactId) || (cs.AccountId != mapOldCase.get(cs.Id).AccountId) || (cs.Subject != mapOldCase.get(cs.Id).Subject) || (cs.Description != mapOldCase.get(cs.Id).Description) || (cs.Origin != mapOldCase.get(cs.Id).Origin) || (cs.Issue_classification__c != mapOldCase.get(cs.Id).Issue_classification__c)) && String.isNotEmpty(profName) && profName == 'Onboarding' &&  profName != 'System Administrator' && userRoleName != 'General Service CCA' && (cs.Status == mapOldCase.get(cs.Id).Status)){
                system.debug('###1235001' + userRoleName );
                system.debug('###123567001' + grpName );
                system.debug('###1235670012' + cs.OwnerId);
                system.debug('###1235670013' + usrId);
                system.debug('###1235670014' + userIdList);
                system.debug('###123567001478' + userIdListNew);
                system.debug('###1235670014789' + grpNameNew);
                system.debug('###123567001478900' + userRoleName);
                cs.AddError('Looks like you don\'t have the permissions to update/create it.');
                return;
            }
        }
        
    }
}