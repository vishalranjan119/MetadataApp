public class MetadataExamples {

    public static void createObject( String[] inputvalues)
    {
        String[] header=new String[]{};
        Integer[] pos=new Integer[10];
        MetadataService.MetadataPort service=createService();
        MetadataService.CustomObject customObject=new  MetadataService.CustomObject();
        List<MetadataService.CustomObject> handleCustomObject=new  List<MetadataService.CustomObject>();
        try{
            header=inputValues[0].split(',');
           }
        catch(Exception e)
        {
            System.debug('Null Pointer Exception:'+e);
        }
        
        System.debug('temp and Size'+header+' '+header.size());
        Integer k=0;
        for(Integer i=0;i<header.size();i++)
        {
            String temp=header[i];
            temp=temp.deleteWhitespace();	
            if(temp.equalsIgnoreCase('label'))
		         pos[0]=i;
            
            if(temp.containsIgnoreCase('pluralLabel'))
                pos[1]=i;            
            
            if(temp.containsIgnoreCase('recordName')||temp.containsIgnoreCase('nameFieldLabel'))
                pos[2]=i;
            
            if(temp.containsIgnoreCase('recordType')||temp.containsIgnoreCase('nameFieldType'))
                pos[3]=i;
            
            if(temp.containsIgnoreCase('deploymentStatus'))
                pos[4]=i;
           
            if(temp.containsIgnoreCase('sharingModel'))
                pos[5]=i;   
        }
        System.debug('Position Array:'+pos);
        
        for(Integer i=1;i<inputValues.size();i++)
        {
            String[] inputValue=inputvalues[i].split(',');
            customObject.fullName = inputvalue[pos[0]].replaceAll('[\\W]', '_')+'__c';
            customObject.label = inputvalue[pos[0]];
            customObject.pluralLabel = inputvalue[pos[1]].trim();
            customObject.nameField = new MetadataService.CustomField();
            customObject.nameField.label = inputvalue[pos[2]].trim();
            customObject.nameField.type_x = inputvalue[pos[3]].trim();
            customObject.deploymentStatus = inputvalue[pos[4]].trim();
            customObject.sharingModel = inputvalue[pos[5]].trim();
         //   handleCustomObject.add(customObject);

            LIST<MetadataService.SaveResult> results=service.createMetadata(new MetadataService.Metadata[] {customObject});
            handleSaveResults(results[0]);
          }
          //LIST<MetadataService.SaveResult> results=service.createMetadata(new List<MetadataService.Metadata[]>{handleCustomObject});
          //handleSaveResults(results[0]);
          
        return;       
    }
    
    public static void createField(String[] inputvalues)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomField customField = new MetadataService.CustomField();
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    
    public class MetadataServiceExamplesException extends Exception { }

}