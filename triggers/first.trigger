trigger first on Prospect__c (before delete, before insert, before update, 
after delete, after insert, after update)
 {
if(Trigger.isAfter)
{
List<Members__c>mylist= new List<Members__c>();
if(Trigger.isInsert)
{

for(Prospect__c p:Trigger.new)
{
if(p.Name=='xyz')
{
mylist.add(new Members__c( Email__c='jdd@kjs.com',Name='jkj',Name__c='hhhh',Phone__c='555555' ));
}
}
insert mylist;
}

if(Trigger.isDelete)
{

for(Prospect__c p:Trigger.old)
{

mylist.clear();

}
delete mylist;
}
}
}