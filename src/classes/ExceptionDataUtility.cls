public class ExceptionDataUtility {
    public static void createException (Exception e) 
    {
        system.debug('i am here');
        Exception__c exObj = new Exception__c();
        if(e.getTypeName().equals('System.DmlException')) {
            integer num=e.getNumDml();
            exObj.numDML__c=num;  
            for(integer i=0;i<num;i++) {
                system.debug(e.getDmlId(i));
                exObj.Exception_Id__c=exObj.Exception_Id__c+ ', '+e.getDmlId(i);
            }
            exObj.Exception_Id__c=exObj.Exception_Id__c.removeStart('null, ');   
        }
        exObj.Organisation_Id__c=UserInfo.getOrganizationId();
        exObj.Line_Number__c = e.getLineNumber();
        exObj.Name=e.getTypeName() + system.now();
        exObj.Exception_Type__c=e.getTypeName();
        exObj.Message__c=e.getMessage();
        exObj.Time_Of_Occurence__c=System.now();
        exObj.Stack_Trace_String__c=e.getStackTraceString();
        exObj.userId__c = UserInfo.getUserId();
        insert exObj;
    }
}