global class AddUsersToChatterGroupsBatch implements Database.Batchable<sObject>{

   global Database.QueryLocator start(Database.BatchableContext BC){
      String query;
      if(Test.isRunningTest()) {
          query = 'SELECT Id,Name,isActive,Profile.Name,UserRoleId,UserRole.Name from User WHERE Profile.Name IN (\'Onboarding\',\'Zeitgold Service Cloud User\',\'Pioneer Service Cloud User\') AND isActive = true LIMIT 1';
      } else {
          query = 'SELECT Id,Name,isActive,Profile.Name,UserRoleId,UserRole.Name from User WHERE Profile.Name IN (\'Onboarding\',\'Zeitgold Service Cloud User\',\'Pioneer Service Cloud User\') AND isActive = true';
      }
        return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<User> scope){
        List<Id> userId = new List<Id>();
        String usrRolName;
        List<CollaborationGroup> groupList = new List<CollaborationGroup>();
        List<CollaborationGroupMember> CollGroupMembers = new List<CollaborationGroupMember>();
        List<CollaborationGroupMember> existingCollGroupMembers = new List<CollaborationGroupMember>();
        //List<CollaborationGroupMember> deleteCollGroupMembers = new List<CollaborationGroupMember>();
        if(!scope.isEmpty()){
            for(User us : scope){
                if(us.UserRoleId != null && String.isNotEmpty(us.UserRole.Name)){
                    userId.add(us.Id);
                    usrRolName = us.UserRole.Name;
                }
            }
            if(!userId.isEmpty() && String.isNotEmpty(usrRolName)){
                
                existingCollGroupMembers = [SELECT Id,MemberId,CollaborationGroupId,CollaborationGroup.Name FROM CollaborationGroupMember WHERE MemberId =: userId[0]];
                if(existingCollGroupMembers.isEmpty()) {
                    groupList = [SELECT id FROM CollaborationGroup WHERE Name=:usrRolName LIMIT 1];
                    if(!groupList.isEmpty()){
                        // Create new member
                        CollaborationGroupMember member = new CollaborationGroupMember();
                        // Add userId
                        member.MemberId = userId[0];
                        // Assign group id to new member
                        member.CollaborationGroupId = groupList[0].Id ;
                        CollGroupMembers.add(member);
                    }
                } else if(!existingCollGroupMembers.isEmpty()){
                    if(existingCollGroupMembers[0].CollaborationGroup.Name != usrRolName){
                        groupList = [SELECT id FROM CollaborationGroup WHERE Name=:usrRolName LIMIT 1];
                        if(!groupList.isEmpty()){
                            // Create new member
                            CollaborationGroupMember member = new CollaborationGroupMember();
                            // Add userId
                            member.MemberId = userId[0];
                            // Assign group id to new member
                            member.CollaborationGroupId = groupList[0].Id ;
                            CollGroupMembers.add(member);
                        }
                        //deleteCollGroupMembers.add(existingCollGroupMembers);
                        delete existingCollGroupMembers;
                    }
                }
            }
            if(!CollGroupMembers.isEmpty()){
                insert CollGroupMembers;
            }
        }
   }
   global void finish(Database.BatchableContext BC){

   }

}