public with sharing class DemoPage2 
{
   public String searchtext{get;set;}
   public Boolean showOption{get;set;} 
   public List<selectOption>options{get;set;}
   public Boolean nameMatched{get;set;}
   public DemoPage2()
      {
	  showOption = false;
      }

   public void ButtonClick()
   {
     if(searchtext !='' && searchtext !='null')
         {
       showOption= true;
       options=new List<selectOption>();
       options.add(new selectOption('','select item'));
       nameMatched=false;

         if(searchtext == 'sudhanshu')
             {
            showOption=true;
            options=new List<selectOption>();
            options.add(new selectOption('name','dwivedi'));
            nameMatched= true;
             }
             else options = null;
           }
           if(nameMatched = true)
           { 
           	 showOption= true;
             
             options.add(new selectOption('company','Navivo'));
           }
   }   
}