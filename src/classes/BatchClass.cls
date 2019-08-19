global class BatchClass implements Database.Batchable<sObject> {

    global List<DataStructure> dsList=new LIST<DataStructure>();
    global String soqlQuery;
    global String fieldName;
    global String selectedObject;
    global Integer countNumberOfFields=0;
    //List<Integer> count = new List<Integer>();
    List<String> fieldList = new List<String>();
    global Integer count;
    Map<String, Integer> countFieldRecordsMap = new Map<String, Integer>();
   	private  Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Count_Object__c countObj;
    
    public BatchClass(List<DataStructure> dsList1, String selectedObject1)
    {
        dsList=dsList1;
        selectedObject=selectedObject1;        
        soqlQuery='';
        for(DataStructure ds: dsList)
        {
            fieldName=ds.fieldName;
            countNumberOfFields++;
            soqlQuery = soqlQuery + fieldname + ', ';
        }
        soqlQuery= soqlQuery.substringBeforeLast(',');
        soqlQuery='Select ' + soqlQuery + ' from ' + selectedObject ;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(soqlQuery);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
        Map<String,Schema.SObjectField> fieldMap=schemaMap.get(selectedObject).getDescribe().fields.getMap();
        System.debug('scope@@'+scope);
                
        List<Count_Object__c> countObjectList = new List<Count_Object__c>();
        for(Schema.SObjectField sfield:fieldMap.values())
        {
            countObj = new Count_Object__c();
            countObj.Name=selectedObject;
            if(sfield.getDescribe().getLocalName().contains('__c'))
            {
                if(!countFieldRecordsMap.containsKey(sfield.getDescribe().getLocalName()))
                {
                    countFieldRecordsMap.put(sfield.getDescribe().getLocalName(),0);
                }
                for(SObject so: scope)
                {
                    if(so.get(sfield.getDescribe().getLocalName())!=null)
                    {
                        count = countFieldRecordsMap.get(sfield.getDescribe().getLocalName());
                        count++;
                        countFieldRecordsMap.put(sfield.getDescribe().getLocalName(),count);                        
                    }
                    else if(so.get(sfield.getDescribe().getLocalName())==null)
                    {
                        count=0;
                        countFieldRecordsMap.put(sfield.getDescribe().getLocalName(),count);                         
                    }
                }
                countObj.ObjectAndFieldName__c = selectedObject + '.' + sfield.getDescribe().getLocalName();
                countObj.Field_Name__c=sfield.getDescribe().getLocalName();
                countObj.Count__c=countFieldRecordsMap.get(sfield.getDescribe().getLocalName());                
                countObjectList.add(countObj);
            }
        }        
       
        if(countObjectList!=null && !countObjectList.isEmpty())
        {
            upsert countObjectList countObj.ObjectAndFieldName__c;
        }
      
    }
    
   global void finish(Database.BatchableContext BC){

   }
}