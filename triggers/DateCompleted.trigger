trigger DateCompleted on Task ( before insert, before update )
{
   Task[] checkTasks = Trigger.new;
   for(Task t : checkTasks){
    t.Subject = 'sudhanshu.salesforce@gmail.com';
   }
}