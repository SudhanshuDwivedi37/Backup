public with sharing class DemoPage3 
{
 public List<Selectoption> State{get;set;}
 public List<Selectoption> City1{get;set;}
 public List<Selectoption> City2{get;set;}
 public List<Selectoption> City3{get;set;}
 public Boolean matched{get;set;}
 public String optionSelected {get;set;}
 public DemoPage3()
     { 
  	
       State= new List<Selectoption>();
       State.add(new Selectoption('Rajasthan','Rajasthan'));
       State.add(new Selectoption('Gujrat','Gujrat'));	
       State.add(new Selectoption('MadhyaPradesh','MadhyaPradesh'));
     }
   
   public void ButtonClick()
   {
   	
  if(optionSelected=='Rajasthan')
      {
  	    City1= new List<Selectoption>();
        City1.add(new Selectoption('name','Jaipur'));
        City1.add(new Selectoption('name','Jodhpur'));
      }
  if(optionSelected=='Gujrat' )
      {
 	    City1= new List<Selectoption>();
        City1.add(new Selectoption('name','Ahemdabad'));
        City1.add(new Selectoption('name','Gandhinagar'));
 	   }
  if(optionSelected=='MadhyaPradesh' )
     {
 	   City1= new List<Selectoption>();
       City1.add(new Selectoption('name','Bhopal'));
       City1.add(new Selectoption('name','Indore'));
 	 
 	  }
   }
}