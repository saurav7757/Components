/*
*Name       : FeedItemTriggerHandler
*Description  : FeedItemTriggerHandler Handler Class is to handle the logic/methods for FeedItem.
*Author    : Saurav Jaiswal
*Date      : 1/2/2019
*
*MODIFICATION LOG:
*DEVELOPER                         DATE                               DESCRIPTION
* ----------------------------------------------------------------------------------------
*                                         
*/ 

public class FeedItemTriggerHandler{

    public static void changeFeedItemType(List<FeedItem> feedItemList, Map<Id,FeedItem> mapOldfeedItem){
        system.debug('$$$$$000012222---->'+ feedItemList);
        Set<Id> stTskIds = new Set<Id>();
        String taskSubTyp;
        for(FeedItem fd : feedItemList){
            String sobjectType = fd.ParentId.getSObjectType().getDescribe().getName();
            if(sobjectType == 'Task'){
                system.debug('$$$$$0000---->'+ sobjectType);
                stTskIds.add(fd.ParentId);
                system.debug('$$$$$---->' + stTskIds);
            }
        }
        if(!stTskIds.isEmpty()){
            List<Task> tskList = [SELECT Id,TaskSubtype FROM Task WHERE Id IN : stTskIds];
            if(!tskList.isEmpty() && tskList[0].TaskSubtype != null){
                taskSubTyp = tskList[0].TaskSubtype;
                system.debug('$$$$$123---->' + taskSubTyp);
            }
        }
        for(FeedItem fd : feedItemList){
            if(String.isNotEmpty(taskSubTyp) && taskSubTyp == 'Call'){
                fd.Type = 'CallLogPost';   
                system.debug('$$$$$1235678---->' + fd.Type); 
            }
        }
    }
}