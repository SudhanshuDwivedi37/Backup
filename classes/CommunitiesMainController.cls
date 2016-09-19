public with sharing class CommunitiesMainController {
    
    public CommunitiesMainController(){
        
    }

    public pagereference login(){
        PageReference page = new Pagereference('https://devjaipur-developer-edition.ap1.force.com/test/login');
        page.setRedirect(true);
        return page;
    }
    
    public pagereference signUp(){
        PageReference page = new Pagereference('https://devjaipur-developer-edition.ap1.force.com/test/CommunitiesSelfReg');
        page.setRedirect(true);
        return page;
    }
}