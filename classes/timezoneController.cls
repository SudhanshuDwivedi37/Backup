public class timezoneController{ 
    public String USDateTime {get;set;}
    public integer UKDateTime {get;set;}    
    public timezoneController() {
        string customerDateTimeString = '2013-02-17 17:35:00';
        DateTime customerDateTime = DateTime.valueofGmt(customerDateTimeString);
        DateTime temp = System.now();
        USDateTime = temp.format('MM/dd/yyyy HH:mm:ss', 'America/New_York');
        UKDateTime = UserInfo.getTimeZone().getOffset(customerDateTime );
        
    } 
}