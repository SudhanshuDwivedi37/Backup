public class TestController {

    public class PicklistWrapper {
        public String value {get;set;}
        public Boolean isSelected {get;set;}
        
        public PicklistWrapper(String value, Boolean isSelected) {
            this.value = value;
            this.isSelected = isSelected;
        }
    }
    
    List<PicklistWrapper> picklistValues{get;set;}
    
    public List<PicklistWrapper> getPicklistValues() {
       picklistValues = new List<PicklistWrapper>();    
       Schema.DescribeFieldResult fieldResult = Contact.cloudera__Country__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
       for( Schema.PicklistEntry f : ple)
       {
           picklistValues.add(new PicklistWrapper(f.getLabel(), false));
       }       
       return picklistValues;
    }
    
    public PageReference showValues() {
    Contact con = [select id, Country__c from Contact where id = '0039000001yNm4W'];
    String temp1 = '';
    String temp2 = '';
        for(PicklistWrapper wrapper : picklistValues) {
            if(Wrapper.isSelected){
                temp1 = wrapper.value;
                temp2 += ';'+temp1;
            }
            
            
            System.debug(wrapper.value + '--->'+wrapper.isSelected);
        }
        con.Country__c = temp2;
        update con;
        return null;
    }
}