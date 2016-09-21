public with sharing class Calculation {
	public Integer gainFromInvestment {get;set;}
	public Integer costOfInvestment {get;set;}
	public Integer returnOnInvestment {get;set;} 
 
  public Calculation(){
  	
  }
  public void calculateReturnOnInvestment(){
   
   returnOnInvestment = (gainFromInvestment-costOfInvestment)/costOfInvestment;
  	
  }
}