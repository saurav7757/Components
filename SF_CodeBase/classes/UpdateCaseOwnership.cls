public without sharing class UpdateCaseOwnership {

    @AuraEnabled
    public static boolean takeOwnershipnCase(String csRecId, String usOrQueueId){
        try{
            Database.SaveResult srList;
            if(String.isNotEmpty(csRecId) && String.isEmpty(usOrQueueId)){
                Case cs = [SELECT Id,OwnerId FROM Case WHERE Id =: csRecId];
                cs.OwnerId = UserInfo.getUserId();
                srList = Database.update(cs, false);
            }
            if(String.isNotEmpty(usOrQueueId) && String.isNotEmpty(csRecId)){
                Case cs = [SELECT Id,OwnerId FROM Case WHERE Id =: csRecId];
                cs.OwnerId = usOrQueueId;
                srList = Database.update(cs, false);    
            }
            if(srList.isSuccess()){
                return true; 
            } else {
                return false; 
            }
        }catch (Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }

}