trigger HelloWorldTrigger on Book__c (before insert)
 {
 for (Book__c b : Trigger.New){
         b.Price__c *= 0.9;
      }
 }