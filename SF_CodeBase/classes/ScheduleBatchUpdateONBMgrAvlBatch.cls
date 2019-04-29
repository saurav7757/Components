global  class ScheduleBatchUpdateONBMgrAvlBatch implements Schedulable {
   global void execute(SchedulableContext BCWHI) {
      UpdateONBMgrAvlBatch WHI= new UpdateONBMgrAvlBatch();
      database.executeBatch(WHI,1);
   }
}