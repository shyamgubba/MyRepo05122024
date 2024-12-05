public class CreateUserBasedOnContactEMail {
    
    
    Public static void createAnUserBasedConEmail(List<String> conIds){
        system.debug('conIds '+conIds);
        List<Contact> lstCons = [Select Id,FirstName,LastName,Email FROM Contact WHERE Id in:conIds];
        system.debug('lstCons '+lstCons);
        Map<String,Contact> mapCon = New Map<String,Contact>();
        if(lstCons.size()>0){
            For(Contact objCon:lstCons){
               mapCon.put(objCon.Email,objCon); 
            }
        }
        
        List<User> lstUser = [Select Id,Email FROM User WHERE Email in:mapCon.keySet()];
        system.debug('lstUser '+lstCons);
        Profile profileName = [Select id FROM Profile WHERE Name =: 'Yash System Admin' limit 1];
        List<User> lstUsers = New List<User>();
        User newUser = New User();
        if(lstUser.size()>0){
            for(User objUser:lstUser){
                if(mapCon.containsKey(objUser.Email)){
                    system.debug('its contains' +mapCon.containsKey(objUser.Email));
                    objUser.Title = 'Emails alreay exist';
                    lstUsers.add(objUser);
                }
                
            }
            
        }else{
            if(mapCon.size()>0){
                system.debug('mapCon.size()>0 ' +mapCon.size());
                for(Contact objContact:mapCon.values()){
                    system.debug('Con Email' +mapCon.get(objContact.Email).EMail);
                    newUser.Email = mapCon.get(objContact.Email).EMail;
                    newUser.ProfileId = profileName.id;
                    newUser.FirstName = mapCon.get(objContact.Email).FirstName;
                    newUser.LastName = mapCon.get(objContact.Email).LastName;
                    lstUsers.add(newUser);
                    system.debug('lstUsers '+lstUsers);
                }
            }
            
        }
        if(lstUsers.size()>0){
            system.debug('lstUsers '+lstUsers);
            Database.upsert(lstUsers,false);
        }
    }

}