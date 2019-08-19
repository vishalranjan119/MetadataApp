public class UtilityClass {
    
    public  Static List<SelectOption> sObjects=new List<SelectOption>();
    Private Static List<SelectOption> allFieldType=new List<SelectOption>();
    Private static Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Private static List<sObjectToSkip__c> sObjectToSkipList = sObjectToSkip__c.getAll().values();
    
    public Static SelectOption[] getAllSObject()
    {
        List<String> entities = new List<String>(schemaMap.keySet());
        Set<String> sObjectToSkipSet = new Set<String>();
        for(sObjectToSkip__c sObjectToSkip:sObjectToSkipList){
            sObjectToSkipSet.add(sObjectToSkip.Name);
        }
        entities.sort();
        String str = '';
        for(String name : entities){  
            Schema.DescribeSObjectResult objDescription = schemaMap.get(name).getDescribe();
            if(! sObjectToSkipSet.contains(objDescription.getName()) && ! objDescription.getName().endsWithIgnoreCase('__History') && ! objDescription.getName().endsWithIgnoreCase('__share')){
               sObjects.add(new SelectOption(objDescription.getName(),objDescription.getName()));
            }
           
        }
        sObjects.sort();
        return sObjects;
    }
    
    public Static SelectOption[] getAllFieldType()
    {
        allFieldType.add(new SelectOption('Checkbox','Checkbox'));
        allFieldType.add(new SelectOption('Currency','Currency'));
        allFieldType.add(new SelectOption('Date','Date'));
        allFieldType.add(new SelectOption('DateTime','DateTime'));
        allFieldType.add(new SelectOption('Number','Number'));
        allFieldType.add(new SelectOption('Percent','Percent'));
        allFieldType.add(new SelectOption('Phone','Phone'));
        allFieldType.add(new SelectOption('Picklist','Picklist'));
        allFieldType.add(new SelectOption('MultiselectPicklist','MultiselectPicklist'));
        allFieldType.add(new SelectOption('TextArea','TextArea'));
        allFieldType.add(new SelectOption('Url','Url'));
        allFieldType.add(new SelectOption('Text','Text'));
        allFieldType.add(new SelectOption('Location','GeoLocation'));
        allFieldType.add(new SelectOption('Email','Email'));
        allFieldType.add(new SelectOption('Html','Rich Text Area'));
        allFieldType.add(new SelectOption('Lookup','Lookup'));
        //allFieldType.add(new SelectOption('REFERENCE','Master Details'));
        allFieldType.add(new SelectOption('LongTextArea','LongTextArea'));
        allFieldType.sort();
        
        return allFieldType;
    }
    
    public Static String correctFieldType(String fieldType)
    {
        if(fieldType.equalsIgnoreCase('STRING'))
            return 'Text';
        if(fieldType.equalsIgnoreCase('CURRENCY'))
            return 'Currency';
        if(fieldType.equalsIgnoreCase('DOUBLE'))
            return 'Number';
        if(fieldType.equalsIgnoreCase('BOOLEAN'))
            return 'Checkbox';
        if(fieldType.equalsIgnoreCase('LOCATION'))
            return 'Location';
        if(fieldType.equalsIgnoreCase('PICKLIST'))
            return 'Picklist';
        if(fieldType.equalsIgnoreCase('DATE'))
            return 'Date';
        if(fieldType.equalsIgnoreCase('PERCENT'))
            return 'Percent';
        if(fieldType.equalsIgnoreCase('PHONE'))
            return 'Phone';
        if(fieldType.equalsIgnoreCase('TEXTAREA'))
            return 'TextArea';
        if(fieldType.equalsIgnoreCase('DATETIME'))
            return 'DateTime';
        if(fieldType.equalsIgnoreCase('URL'))
            return 'Url';
        if(fieldType.equalsIgnoreCase('EMAIL'))
            return 'Email';
        if(fieldType.equalsIgnoreCase('MULTIPICKLIST'))
            return 'MultiselectPicklist';
        if(fieldType.equalsIgnoreCase('REFERENCE'))
            return 'Lookup';
        
        return fieldType;
        
    }
    
    public  static void changeStructure(DataStructure ds){
        if(ds.dataTypeContainsLengthField.contains(ds.changedDataType))
            ds.length='0';
        else
            ds.length=null;
        
        if(ds.dataTypeContainsDecimalPlaceField.contains(ds.changedDataType))
            ds.decimalPlace='0';
        else
            ds.decimalPlace=null;
        
        if(ds.dataTypeContainsVisibleLinesField.contains(ds.changedDataType))
            ds.visibleLines='3';
        else
            ds.visibleLines=null;
        
        if(ds.changedDataType=='Picklist'||ds.changedDataType=='MultiselectPicklist'){
            ds.picklistValue='';
            ds.picklistSortedCheck='';
        }
        else{
            ds.picklistValue=null;
            ds.picklistSorted=null;
            ds.picklistSortedCheck=null;
        }
        
        if(ds.dataTypeContainsDefaultField.contains(ds.changedDataType)){
            if(ds.changedDataType=='Checkbox'){
                 ds.fieldDefaultValue='false';
            }
            ds.fieldDefaultValue=''; 
        }   
        else                
            ds.fieldDefaultValue=null;       
        if(ds.dataTypeContainsRequiredField.contains(ds.changedDataType) || ds.changedDataType=='REFERENCE' ){
            ds.required=false;                    
            ds.requiredCheck='';
        }
        else{
            ds.required=null;
            ds.requiredCheck=null;
        }
        
        if(ds.dataTypeContainsUniqueField.contains(ds.changedDataType)){
            ds.unique=false;
            ds.uniqueCheck='';
        }
        else{
            ds.unique=null;
            ds.uniqueCheck=null;
        }
        
        if(ds.dataTypeContainsExternalIDField.contains(ds.changedDataType)){                   
            ds.externalId=false;   
            ds.externalIdCheck='';
        }
        else{
            ds.externalId=null;
            ds.externalIdCheck=null;
        }
        if(ds.changedDataType=='Lookup'){
            ds.childRelationshipName ='';
            ds.relatedToObject = '';
            ds.relatedListLabel ='';
            ds.lookupFieldCheck ='';    
        }
        else{
            ds.lookupFieldCheck =null;
        }
    }   
}