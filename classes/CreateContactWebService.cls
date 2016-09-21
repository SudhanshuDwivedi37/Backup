global class CreateContactWebService{

    webservice Static Id makeContact(String lastName, Account a){
        Contact con = new Contact();
        con.LastName = lastName;
        con.AccountId = a.Id;
        insert con;
        return con.Id; 
    
    }

}