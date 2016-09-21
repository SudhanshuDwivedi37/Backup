public with sharing class DemoPage1 {
 public Account acc {get;set;}
 public Contact cont{get;set;}
 public list<Selectoption> IsOptions {get;set;}
Public DemoPage1()
{
 acc = new Account();
 cont = new Contact();
 IsOptions=new List<Selectoption>();
 IsOptions.add(new Selectoption('','None'));
 IsOptions.add(new Selectoption('Phone','Phone'));
 IsOptions.add(new Selectoption('Web','Web'));
}
public DemoPage1(Apexpages.standardController sc)
 {
 }
 
 public pagereference saveAccount()
 {
      insert acc;
      Pagereference pr = new Pagereference('/' + acc.ID);
      return pr;
 }  

}