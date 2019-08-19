public class BulkFieldUpdatorController {
    
    private  Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    private  List<SelectOption> objNames = new List<SelectOption>();
    private  List<SelectOption> dataTypeOptions = new List<SelectOption>();
    public  String selectedObject{get;set;}
    public String changedDataType{get;set;}
    private  List<DataStructure> dsList=new LIST<DataStructure>();
    private  List<DataStructure> dsListToUpdate=new LIST<DataStructure>();
    private  List<DataStructure> picklistDsList=new LIST<DataStructure>();
    private Boolean isgetObjCalled=false;
    private Boolean isgetdsListCalled=false;
    private  String pageBlockSectionTitle{get;set;}
    public Boolean iscreateDataTypeSelectOptionCalled{get;set;}
    public Boolean isUpdateMetadataCalled{get;set;}
    public  Boolean isRerenderSave{get;set;}
    Map<String,List<SelectOption>> picklistChangeMap;
    public List<String> tableHeader{get;set;}
    
    public BulkFieldUpdatorController(){
       tableHeader = new List<String>{'','Data Type', 'Label','Field Name', 'Length', 'Decimal Places', 
            'Visible Lines','Picklist Values','Picklist Sorted','Default Value','Required','ExternalId','Unique',
            'Related To Object','Child Relationship Name','Related List Label','Help Text'}; 
    }
    
    public PageReference updateMetadata()
    {
        isUpdateMetadataCalled=true;
        fieldsToUpdate();
        MetadataApi.updateField(dsListToUpdate);
        if(picklistDsList.size()>0 && !picklistDsList.isEmpty()){
            MetadataApi.updateField(picklistDsList);
        }
        	
        PageReference pageref = new PageReference('/apex/BulkFieldUpdatorNew_tarun');
            return pageref;
    }
    
    public PageReference createEditStructure()  {
        dsList.clear();
        typeChangePicklistSetter();
        isUpdateMetadataCalled=false;
        System.debug('createDataStructur'+selectedObject);
        Map<String,Schema.SObjectField> fieldMap=schemaMap.get(selectedObject).getDescribe().fields.getMap();
        System.debug('Fields@@:'+fieldMap);
        isRerenderSave=true;
        if(fieldMap.values()!=null && !fieldMap.values().isEmpty())
        {
            for(Schema.SObjectField sfield:fieldMap.values())
            {
                DataStructure ds=new DataStructure();
                if(String.valueOf(sfield).contains('__c'))
                {
                    ds.objectName=selectedObject;
                    ds.fieldType=UtilityClass.correctFieldType(String.valueOf(sfield.getDescribe().getType()));
                    
                    if(ds.fieldType=='Lookup'  && sfield.getDescribe().isNillable()==false)
                        ds.fieldType='REFERENCE';
                    
                    ds.changedDataType=ds.fieldType;
                    ds.fieldLabel=sfield.getDescribe().getLabel();       		
                    ds.fieldName=sfield.getDescribe().getLocalName();	
                    
                    if(ds.dataTypeContainsLengthField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().getLength()!=null)
                            ds.length=String.valueOf(sfield.getDescribe().getLength());
                        else
                            ds.length='0';
                    }
                    if(ds.dataTypeContainsPrecisionField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().getPrecision()!=null)
                            ds.length=String.valueOf(sfield.getDescribe().getPrecision());
                        else
                            ds.length='0';
                    }
                    
                    if(ds.dataTypeContainsDecimalPlaceField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().getScale()!=null)
                            ds.decimalPlace=String.valueOf(sfield.getDescribe().getScale());
                        else
                            ds.decimalPlace='0';    
                    }
                    if(ds.fieldType=='Picklist'||ds.fieldType=='MultiselectPicklist')
                    {
                        ds=picklistStructure(ds, sfield);
                    }
                    if(ds.dataTypeContainsDefaultField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().getDefaultValue()!=null)
                            ds.fieldDefaultValue=String.valueOf(sfield.getDescribe().getDefaultValue());
                        else
                            ds.fieldDefaultValue='';                
                    }            
                    if(ds.dataTypeContainsRequiredField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().isNillable()!=null)
                            ds.required=(!sfield.getDescribe().isNillable());
                        
                        ds.requiredCheck='';
                    }
                    
                    //if(inputvalue[11].trim()!=null && inputvalue[11].trim()!='')
                    //ds.trackFeedHistory=Boolean.valueOf(inputvalue[11].trim());
                    
                    if(ds.dataTypeContainsUniqueField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().isUnique()!=null)
                            ds.unique=sfield.getDescribe().isUnique();
                        
                        ds.uniqueCheck='';
                    }
                    
                    
                    if(ds.dataTypeContainsExternalIDField.contains(ds.fieldType))
                    {
                        if(sfield.getDescribe().isExternalID()!=null)
                            ds.externalId=sfield.getDescribe().isExternalID();
                        
                        ds.externalIdCheck='';
                    }
                    
                    if(ds.fieldType=='Lookup' || ds.fieldType=='REFERENCE'  )
                    {
                        ds.relatedToObject=String.valueOf(sfield.getDescribe().getReferenceTo()[0]);
                        ds.relatedListLabel=sfield.getDescribe().getRelationshipName();
                        ds.childRelationshipName=sfield.getDescribe().getRelationshipName();
                    }
                    
                    ds.helpText=sfield.getDescribe().getInlineHelpText();
                    ds.dataTypeChangePickListValues = new List<SelectOption>();
                    ds.dataTypeChangePickListValues = picklistChangeMap.get(ds.fieldType);
                    //ds.dataTypeChangePickListValues.add(new SelectOption(ds.fieldType,ds.fieldType));
                    dsList.add(ds);
                    
                }
            }
            // modified by Sahil Wadhwa 15-07-2016
        }
        
        return null;
    }
    
    public DataStructure picklistStructure(DataStructure ds, Schema.SObjectField sfield)
    {
        if(sfield.getDescribe().getPicklistValues()!=null)
        {
            List<Schema.PicklistEntry> pickListEntry=sfield.getDescribe().getPicklistValues();
            
            ds.picklistValues=new List<String>();
            //ds.picklistValues.addAll(sfield.getDescribe().getPicklistValues());
            ds.picklistValue = '';
            for(Schema.PicklistEntry pe : pickListEntry) {
                String str=pe.getLabel();
                ds.picklistValue = ds.picklistValue +str + '\n';
            }
        }
        else
            ds.picklistValue='';
        
        if(sfield.getDescribe().isSortable()!=null)
            ds.picklistSorted=sfield.getDescribe().isSortable();
        
        ds.picklistSortedCheck='';
        
        return ds;
    }
    
    public PageReference changeStructure()
    {
        for(DataStructure ds:dsList)
        {
            System.debug('Changed Data Type:'+ds.changedDataType+':'+ds.fieldType);
            
            if(ds.isUpdatable)
            {	
                if(ValidateData.validateConversionOfFieldType(ds))
                {  
                
                  if(ds.dataTypeContainsRequiredField.contains(ds.fieldType))
                    {
                        MetadataApi.setRequiredToFalse(new List<DataStructure>{ds});
                    }	
   					UtilityClass.changeStructure(ds);
                }
            }
        }
        return null;
    }
    
  
    
    public void fieldsToUpdate()
    {
        for(DataStructure ds:dsList)
        {
            if(ds.isUpdatable)
            {
                dsListToUpdate.add(ds);
                if(ds.changedDataType=='Picklist' || ds.changedDataType=='MultiselectPicklist')
                    picklistDsList.add(ds);
            }
        }
    }
    
    public PageReference initialState()
    {
        for(DataStructure ds:dsList)
        {
            if(ds.isUpdatable)
            {
                if(ds.changedDataType != ds.fieldType)
                {
                    ds.changedDataType=ds.fieldType;
                }
            }
        }
        return null;
    }
        
    public  List<SelectOption> getobjNames() 
    {
        System.debug('getobjNames'+isgetObjCalled);
        if(!isgetObjCalled)
        {
            isgetObjCalled=true;
            objNames=UtilityClass.getAllSObject();
        }
        return objNames;
    }
    
    Boolean isGetDataTypeOptions=false;
    public  List<SelectOption> getdataTypeOptions() 
    {
        if(!isGetDataTypeOptions)
        {
            isGetDataTypeOptions=true;
             dataTypeOptions = UtilityClass.getAllFieldType();
        }
           
        return dataTypeOptions;
    }
    
    public List<DataStructure> getdsList()
    {
        System.debug('Inside getdsList');
        if (dsList!= NULL)
            if (dsList.size() > 0)
            return dsList;
        else
            return null;                    
        else
            return null;
    }
    public void typeChangePicklistSetter()
    {
        List<FieldsTypeChangeList__c> picklistValues = FieldsTypeChangeList__c.getall().values();
        picklistChangeMap = new Map<String,List<SelectOption>>();
        for(FieldsTypeChangeList__c picklistValue:picklistValues)
        {
            if(picklistValue.ConvertTo__c != NULL)
            {
                List<SelectOption> tempList = new List<SelectOption>();
                tempList.add(new SelectOption('--None--','--None--'));
                for(String str: picklistValue.ConvertTo__c.split(';')){
                    tempList.add(new SelectOption(str,str));
                }
                picklistChangeMap.put(picklistValue.Name,tempList);
            }
        }
        System.debug('picklistChangeMap'+picklistChangeMap);
    }
}