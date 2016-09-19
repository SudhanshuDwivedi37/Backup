trigger SFDC_FederationID_Test on User (before insert) { 
    List<Profile> prList = new List<Profile>();
    prList  = [select id, UserLicense.Name from Profile where Name =: 'Customer Community User'];
    
    for(user u : trigger.new){
        if(u.Profile.id == '00e90000001PM26'){
            system.debug('uuuu::'+u.UserName);
            u.FederationIdentifier = u.UserName;
        }
    
    }
    
 }