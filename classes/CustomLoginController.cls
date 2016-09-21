public class CustomLoginController {

    public String username{get; set;}
    public String password {get; set;}

    public pageReference Login(){  
        
        return Site.login(username,password,'/apex/SingleSignOn');
    }
    
    public pageReference redirectToPdf(){  
        pageReference pr = new pageReference('/TestPdf'); 
        pr.setRedirect(true);
        return pr;
    }
    
    public pageReference forgotPassword(){  
        pageReference pr = new pageReference('/CustomForgotPassword'); 
        pr.setRedirect(true);
        return pr;
    }
}