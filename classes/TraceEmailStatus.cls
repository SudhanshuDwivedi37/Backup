public class TraceEmailStatus{
    public Integer numOfTimesOpened;
    public List<Email_Trace__c> emailTrace;
    Public String patientId ;
    Public String patientTimeZone ;
    Public String mettingTime ;
    public TraceEmailStatus(){
        
        numOfTimesOpened = 0;
        /*emailTrace = new List<cloudera__Email_Trace__c>();
        emailTrace = [Select Contact__c, Email_Template_Name__c, Last_Time_Opened__c, Number_Of_Times_Email_Opened__c from Email_Trace__c];*/
    }
    
    public void traceEmail(){
         
         
         if( ApexPages.currentPage().getParameters().get('conId') != '' &&  ApexPages.currentPage().getParameters().get('conID') != null){
            patientId = ApexPages.currentPage().getParameters().get('conId');
        }
        
        if( ApexPages.currentPage().getParameters().get('TempName') != '' &&  ApexPages.currentPage().getParameters().get('TempName') != null){
            patientTimeZone = ApexPages.currentPage().getParameters().get('TempName');
        }
        
        if( ApexPages.currentPage().getParameters().get('Status') != '' &&  ApexPages.currentPage().getParameters().get('Status') != null){
            mettingTime = ApexPages.currentPage().getParameters().get('Status');
        }
        System.debug('d::::::::::');
        
        System.debug('patientId :::'+patientId);
        System.debug('patientTimeZone :::'+patientTimeZone );
        System.debug('mettingTime :::'+mettingTime );
        
        Email_Trace__c emailTrace = new Email_Trace__c () ;
        emailTrace.Number_Of_Times_Email_Opened__c = numOfTimesOpened + 1 ;
        emailTrace.Last_Time_Opened__c = Datetime.now() ;
        emailTrace.Contact__c = patientId;
        upsert emailTrace; 
        
    }

}