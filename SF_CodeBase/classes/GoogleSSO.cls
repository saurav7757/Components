//TODO:This autogenerated class includes the basics for a Registration
//Handler class. You will need to customize it to ensure it meets your needs and
//the data provided by the third party.

global class GoogleSSO implements Auth.RegistrationHandler{

global User createUser(Id portalId, Auth.UserData data){
      User u = [SELECT Id FROM User WHERE Email =: data.email];
      return u;
}

global void updateUser(Id userId, Id portalId, Auth.UserData data){
  
}
}