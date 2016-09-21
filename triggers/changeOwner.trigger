trigger changeOwner on Case (before update) {

for(case c : trigger.new)
if(Trigger.isBefore && Trigger.isUpdate){
       UpdateOwner.Updatecase(Trigger.new, Trigger.oldMap);
    }
}