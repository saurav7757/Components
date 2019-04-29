global class batchTaskUpdate implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
      String query = 'SELECT Id,Name from Opportunity';
        return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Opportunity> scope){
        update scope;
   }
   global void finish(Database.BatchableContext BC){

   }

}