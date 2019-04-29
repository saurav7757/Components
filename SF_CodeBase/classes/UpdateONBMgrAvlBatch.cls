global class UpdateONBMgrAvlBatch implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
      String query = 'SELECT Id,Name,Profile.Name from User WHERE Profile.Name = \'Onboarding\'';
        return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<User> scope){
        system.debug('###1' + scope);
        List<User> lstToUpdate = new List<User>();
        Set<Id> usrIds = new Set<Id>();
        Map<String, Integer> myMap = new Map<String,Integer>();
        Set<String> listDateSet = new Set<String>();
        List<String> listDate = new List<String>();
        for(User usr : scope){
            usrIds.add(usr.Id);
        }
        List<Account> lstAcc = [SELECT Id, Name, Onboarding_Manager__r.Name,Go_Live_Date__c from Account where Onboarding_Manager__c IN : usrIds order by Go_Live_Date__c desc];
        system.debug('###2' + lstAcc);
        for(Account acc : lstAcc){
            if(acc.Go_Live_Date__c != null){
                listDate.add(acc.Go_Live_Date__c.format());
            }
        }
        listDate.sort();
        listDateSet.addAll(listDate);
        for(String str: listDateSet){
            Integer countofChar = 0;
            for(String strl: listDate){
               if(str == strl){
                 countofChar++;
               }
            }
            myMap.put(str, countofChar);
            system.debug('###3' + myMap);
        }
        List<Onboarding_Manager_Availability__c> onbAval = [SELECT Id,Month__c,Related_Onboarding_Manager__c,Total_Capacity__c,Remaining_Capacity__c FROM Onboarding_Manager_Availability__c WHERE Related_Onboarding_Manager__c IN : usrIds];
        List<Onboarding_Manager_Availability__c> onbAvalToUpdate = new List<Onboarding_Manager_Availability__c>();
        for(Onboarding_Manager_Availability__c onb : onbAval){
            Integer countAval = myMap.get(onb.Month__c.format());
            if(countAval != null){
                onb.Remaining_Capacity__c = onb.Total_Capacity__c - countAval;
                onbAvalToUpdate.add(onb);
            }else{
                onb.Remaining_Capacity__c = onb.Total_Capacity__c;
                onbAvalToUpdate.add(onb);
            }
        }
        system.debug('###4' + onbAvalToUpdate);
        update onbAvalToUpdate;
   }
   global void finish(Database.BatchableContext BC){

   }

}