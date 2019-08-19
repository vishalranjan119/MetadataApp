public class ExportToExcelMultipleSheets {

    
    public List<Contact> cs{get;set;}
    public List<Contact> l1=[Select Id, Name from Contact];
    
public transient List<account> accountList{get;set;}
public transient List<contact> contactList{get;set;}
public String xlsHeader{
    get{
        String strHeader = '';
        strHeader += '<?xml version="1.0"?>';
        strHeader += '<?mso-application progid="Excel.Sheet"?>';
        return strHeader;
    }
}
public ExportToExcelMultipleSheets(){
    accountList = [select Name,Id from Account LIMIT 10];
    contactList = [SELECT id,Name, LastName, Account.Name, Email FROM Contact WHERE Email != '' AND Account.Name != '' LIMIT 5];
	cs=new List<Contact>();
        for(Contact c: l1)
            cs.add(c);

}
public Pagereference exportAll(){
    return new Pagereference('/apex/ExportAll');
    }
    
   }