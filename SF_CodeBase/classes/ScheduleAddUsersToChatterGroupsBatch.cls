global  class ScheduleAddUsersToChatterGroupsBatch implements Schedulable {
   global void execute(SchedulableContext BCWHI) {
      AddUsersToChatterGroupsBatch WHI= new AddUsersToChatterGroupsBatch();
      database.executeBatch(WHI,1);
   }
}