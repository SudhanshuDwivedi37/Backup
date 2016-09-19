public Class PlainTextTestPage{
    
    public String htmlText{get;set;} 
    public String plainText{get;set;} 
   
    public PlainTextTestPage(){
    }
    
    public void submit(){
        plainText = UtilityClass.getPaseHTML(htmlText);
        
    }
}