/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class SiteLoginController {
    global String username {get; set;}
    global String password {get; set;}

    global PageReference login() {
        try{
            String startUrl = System.currentPageReference().getParameters().get('startURL');      
            return Site.login(username, password, 'https://www.securevideo.com');
        }
         catch(Exception e)
        {
            String error = e.getMessage();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,error));
            return null;
        }
    }
    
    global SiteLoginController () {}
}