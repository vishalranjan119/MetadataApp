public class ExcelUploadController {
public List<Account> forInsert{get;set;}
    public String myString {get;set;}
    public Boolean status {get;set;}
    public String message {get;set;}
    String successString;
    String errorString;
    String fileRow;
    public List<CustomLabelDS> customLabels= new List<CustomLabelDS>();
    public Set<String> fieldsPresent{get;set;}
    List<String> fieldsPresentList;
    public transient Component.Apex.PageBlockTable table{get;set;}
    public ExcelUploadController(){
        successString='';
        errorString='';
        fileRow='';
        myString= '';
        status= false;
        fieldsPresent= new Set<String>();
        
        fieldsPresentList = new list<String>();
    }
  public void previewData(){
      System.debug(myString);
        status= true;
        parseJSONString();
        table = new Component.Apex.PageBlockTable(var='acc');
        table.expressions.value='{!forInsert}';
        for(String str: fieldsPresent){
            Component.Apex.OutputField outputField = new Component.Apex.OutputField();
            outputField.expressions.value = '{!acc.' + str + '}';
            Component.Apex.Column column = new Component.Apex.Column(headerValue=str);
            column.childComponents.add(outputField);
            table.childComponents.add(column);
            fieldsPresentList.add(str);
        }
    } 
 public PageReference insertData(){
        if(forInsert.size()>0){
            Database.SaveResult[] srList =  Database.insert(forInsert,false);            
            successString = 'Record Id';
            for(String str: fieldsPresentList){
                successString = successString + ','+ str;
                errorString = errorString +  str + ',';
            }
            errorString = errorString + 'Error Message\n ';
            successString = successString+'\n';
            for (Integer i=0;i<srList.size();i++) {
                if (!srList[i].isSuccess()) {
                    for(String str: fieldsPresentList){
                        errorString = errorString + forInsert.get(i).get(str) + ',';
                    }
                    for(Database.Error err : srList[i].getErrors()) {
                        errorString = errorString + '---'+ err.getMessage()+'---';
                    }
                    errorString = errorString + '\n';
                }else{
                    successString = successString + srList[i].getId();
                    for(String str: fieldsPresentList){
                        successString = successString + ','+ forInsert.get(i).get(str);
                    }
                    successString= successString + '\n';
                }
            }
        }
        System.debug('successString'+successString);
        System.debug('errorString'+errorString);
        Messaging.EmailFileAttachment csvAttachmentSuccess = new Messaging.EmailFileAttachment();
        Messaging.EmailFileAttachment csvAttachmentError = new Messaging.EmailFileAttachment();
        Blob csvBlob = blob.valueOf(successString);
        String csvName = 'Success_'+Date.today()+'.csv';
        csvAttachmentSuccess.setFileName(csvName);
        csvAttachmentSuccess.setBody(csvBlob);
        csvBlob = blob.valueOf(errorString);
        csvName = 'Error_'+Date.today()+'.csv';
        csvAttachmentError.setFileName(csvName);
        csvAttachmentError.setBody(csvBlob);
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{UserInfo.getUserEmail()};
        String subject = 'Account Records Uploaded';
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setPlainTextBody('Please find attached success and error files for the recent account records upload.');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttachmentSuccess,csvAttachmentError});
        Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        return new PageReference('/apex/GenerateOutputFiles');
    } 
    
    public void parseJSONString() 
    {
        String jsonStr = myString;
        //System.debug('Json String = '+jsonStr);
        if(jsonStr!=null && jsonStr!='' )
        {
            JSONParser parser = JSON.createParser(jsonStr);
            while (parser.nextToken() != null) 
            {
                if (parser.getCurrentToken() == JSONToken.START_ARRAY) 
                {
                    while (parser.nextToken() != null) 
                    {
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT) 
                        {
                            CustomLabelDS cl = (CustomLabelDS)parser.readValueAsStrict(CustomLabelDS.class);
                            //System.debug(cl.labelName);
                            customLabels.add(cl);
                           	String s = JSON.serialize(cl);
                            //system.debug('Serialized CustomLabel: ' + s);
                            parser.skipChildren();
                        }
                    }
                }
            }
            /*
            JSONParser parser = JSON.createParser(jsonStr);
        	Integer count=0;
            while (parser.nextToken() != null) 
            {
                CustomLabelDS cl= new CustomLabelDS();
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'categories')) 
                    {
                        // Get the value.
                        parser.nextToken();
                        cl.categories=parser.getText();
                        // Compute the grand total price for all invoices.
                        System.debug('cat-'+parser.getText());
                        System.debug(count);
                    }
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'labelValue')) 
                    {
                        // Get the value.
                        parser.nextToken();
                        cl.labelValue=parser.getText();
                        // Compute the grand total price for all invoices.
                        System.debug(parser.getText());
                        System.debug(count);
                    }
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'shortDesc')) 
                    {
                        // Get the value.
                        parser.nextToken();
                        cl.shortDesc=parser.getText();
                        // Compute the grand total price for all invoices.
                        System.debug(parser.getText());
                        System.debug(count);
                    }
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'labelName')) 
                    {
                        // Get the value.
                        parser.nextToken();
                        cl.labelName=parser.getText();
                        // Compute the grand total price for all invoices.
                        System.debug(parser.getText());
                        System.debug(count);
                    }
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'labelProt')) 
                    {
                        // Get the value.
                        parser.nextToken();
                        cl.labelProt=boolean.valueOf(parser.getText());
                        // Compute the grand total price for all invoices.
                        System.debug(parser.getText());
                        System.debug(count);
                    }
                count++;
                
                customLabels.add(cl);
            }
            */
            fieldsPresent.remove('attributes');
            
            /* for(CustomLabelDS ds:customLabels)
                {
                    System.debug(ds);
                }
*/
        }

    } 
}