public class ExceptionTesting {
    public static void returnContactList()
    {
        list<contact> contactList = new list<contact>();
    contact con = new contact();
    con.lastname='sahil';
        con.AccountId='00136000009aDk9';
        contactList.add(con);
    con.lastname='himani';
        con.AccountId='00136000009aDp9'; 
        contactList.add(con);
        con.lastname='nitish';
        con.AccountId='00136000009aDl9'; 
        contactList.add(con);
        createTestException(contactList);
    }
    public static void createTestException(list<contact> contactList )
    {
        try {
            insert contactList;
        }
        catch(exception e) {
          system.debug('Error Detcted');
            ExceptionDataUtility.createException(e); 
        }
    }    
  
}