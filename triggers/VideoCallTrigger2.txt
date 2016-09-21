trigger VideoCallTrigger on Video_Call__c (after insert,before update,before insert) {
    String dTemp;
    DateTime dt;
    DateTime now = DateTime.now();
    Long offset = DateTime.newInstance(now.date(), now.time()).getTime() - DateTime.newInstance(now.dateGmt(), now.timeGmt()).getTime(); 
    Long currentUserHourDifference = (offset/60000);
    if(trigger.isAfter){
        List<Task>tskList = new List<Task>();
        if(trigger.isInsert){  
            for(Video_Call__c vCall : trigger.new){
                
                Task task = new Task();
                task.WhatID = vCall.Id;
                task.Status = 'Not Started';
                task.Type = 'Video Call';
                task.subject = 'Video Call';
                task.ownerId = vCall.ownerId;
                task.priority = 'Normal';
                   
                if(vCall.Patient_Time_Zone__c== 'Eastern Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(4);  
                } 
                
                else if(vCall.Patient_Time_Zone__c== 'Central Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(5);  
                }
                
                else if(vCall.Patient_Time_Zone__c== 'Pacific Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(7);  
                }
                
                else if(vCall.Patient_Time_Zone__c== 'Mountain Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(6);  
                }
                
                else if(vCall.Patient_Time_Zone__c== 'Alaskan Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(9);  
                }
                
                else if(vCall.Patient_Time_Zone__c== 'Hawaiian Standard Time'){
                    dt = vCall.Scheduled_Time__c.addHours(10);  
                }
                dt = dt.addMinutes(integer.valueOf(currentUserHourDifference));
                task.ActivityDate = date.newinstance(dT.year(), dT.month(), dT.day());  
                task.Time_Custom__c = dT.format('hh:mm:ss a');   
                tskList.add(task);         
            }          
            insert tskList;              
         }       
     }
     
     if(trigger.isBefore){
         if(trigger.isUpdate){
             Task task = [Select id from task where WhatId = :Trigger.new]; 
             for(Video_Call__c vCall : trigger.new){    
                    vCall.Nurse_TimeZone__c = UserInfo.getTimeZone().getDisplayName();
                    if(vCall.Patient_Time_Zone__c== 'Eastern Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(4);  
                    } 
                    
                    else if(vCall.Patient_Time_Zone__c== 'Central Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(5);  
                    }
                    
                    else if(vCall.Patient_Time_Zone__c== 'Pacific Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(7);  
                    }
                    
                    else if(vCall.Patient_Time_Zone__c== 'Mountain Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(6);  
                    }
                    
                    else if(vCall.Patient_Time_Zone__c== 'Alaskan Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(9);  
                    }
                    
                    else if(vCall.Patient_Time_Zone__c== 'Hawaiian Standard Time'){
                        dt = vCall.Scheduled_Time__c.addHours(10);  
                    }
                    dt = dt.addMinutes(integer.valueOf(currentUserHourDifference));
                    task.ActivityDate = date.newinstance(dT.year(), dT.month(), dT.day());  
                    task.Time_Custom__c = dT.format('hh:mm:ss a');   
               }  
               if(task != null){
                   update task; 
               }
           }               
      }              
 }