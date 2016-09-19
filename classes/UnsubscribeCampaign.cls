public without sharing class UnsubscribeCampaign {
        public String emailAddress {get;set;}
        public List <Lead> leadList {get;set;}
        public List <Contact> conList {get;set;}
        public List <CampaignMember> campMemberList {get;set;}
        public List <Campaign >campList {get;set;}
        public Set<Id>leadSet {get;set;}
        public Set<Id>contactSet {get;set;}
        public set<Id>campSet {get;set;}
        public List<wrapper> wrapper{get;set;}
        public Boolean showPanelUnsubscribe {get;set;}
        public Boolean showPanelCampaign {get;set;}
        public set<id>campMemId {get;set;}
        public String message {get;set;}
        public String accId {get;set;}
        public Account acc {get;set;}
        
        public UnsubscribeCampaign(){
             system.debug('xxxx');
             system.debug('time'+system.now());
             if(Apexpages.currentPage().getParameters().containsKey('accId')){
                   accId= ApexPages.currentPage().getParameters().get('accID');   
             } 
             system.debug('accId '+accId );  
             leadList = new List<Lead>();
             conList = new List<Contact>();
             campMemberList = new List <CampaignMember>();
             campList = new List <Campaign>();
             leadSet = new Set<Id>();
             contactSet = new Set<Id>();
             campSet = new Set<Id>();
             campMemId = new Set<Id>();
             showPanelUnsubscribe = true;
             showPanelCampaign = false;
             
             if(Apexpages.currentPage().getParameters().containsKey('Email')){
                   emailAddress = ApexPages.currentPage().getParameters().get('Email');   
            }   
            
            
        }
        
        public PageReference next(){
            try{
                if(emailAddress != null && emailAddress != ''){
                    showPanelUnsubscribe = false;
                    showPanelCampaign = true;
                    leadList = [select id from Lead where Email = : emailAddress];
                    conList = [select id from Contact where Email =: emailAddress];
                    system.debug('leadList'+leadList);
                    system.debug('conList'+conList);
                    
                    for(Lead l : leadList){
                        leadSet.add(l.Id);
                    }    
                    for(Contact con : conList){
                        contactSet.add(con.Id);
                    }
                    campMemberList = [select id, CampaignId from CampaignMember where LeadId IN :leadSet OR ContactId IN: contactSet ];
                    system.debug('campMemberList'+campMemberList);
                    
                    for(CampaignMember c: campMemberList){
                            campSet.add(c.Id);
                          campMemId.add(c.CampaignId);
                    }
                    campList = [select Id,  Name from Campaign where Id IN :campMemId  and IsActive = true ];
                         system.debug('campList'+campList);
                    
               if(campList.size() == 0){
                         showPanelCampaign = false;
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error,'You are not a member of any active campaign.'));
                         return null;
                    }
                    wrapper = new List <wrapper>();
                  for(Campaign cam :campList ){
                         Wrapper wrap = new Wrapper(cam,false);
                         system.debug('wrap'+wrap);
                       wrapper.add(wrap);
          }     
                }
                else{
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error,'Please Fill Email Address.'));
             showPanelCampaign = false;
             return Null;
                } 
            }catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getMessage()));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getstacktracestring()));
      }   
                 return Null;
            }
        public PageReference submit(){
            try{
             List<String>campId = new List<String>();
             List<CampaignMember>cam = new List<CampaignMember>();
             for(Wrapper w : wrapper){
                    if(w.isSelected){
                         campId.add(w.camp.Id);
                    }
                    else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Error,'Please Select CheckBox'));
                        return null;
                    }
                    cam = [select id from CampaignMember where CampaignId IN :campId AND id IN : campSet];
                    system.debug('cam111'+cam);
                }
                delete(cam);
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.Confirm,'You are successfully unsubscribed from selected campaign.'));
                  showPanelCampaign = false;
                          
                 
            } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getMessage()));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getstacktracestring()));
      }   
        return Null;
        }

        public void updateTime(){
             
            acc = [select Modified_Time__c, Name from  Account where id=: accId];
            if(accId != '' && accId != null){
                acc.Modified_Time__c = system.now();
                update acc;
               
               system.debug('acc'+acc.Modified_Time__c );
            }
            
             
        }
        
        public class Wrapper{
            public Campaign camp{get;set;}
            public Boolean isSelected{get;set;}
           
            
            public Wrapper(Campaign camp,Boolean isSelected){
                this.camp = camp;
                this.isSelected = isSelected;
            }
}
}