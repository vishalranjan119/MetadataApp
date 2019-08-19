public class MetadataApi {    
    
    	    
    static List<MetadataService.DeleteResult> deleteResult=new List<MetadataService.DeleteResult>();
    
    public static void createField(LIST<DataStructure> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        results=insertDataInCustomField(dsList,service,'CREATE');
        handleSaveResults(results,dsList);
    }
    
    public static void updateField(LIST<DataStructure> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        results=insertDataInCustomField(dsList,service,'UPDATE');
        handleSaveResults(results,dsList);
    }
    
    public static void setRequiredToFalse(LIST<DataStructure> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        results=insertDataInCustomField(dsList,service,'UPDATERequired');
        System.debug('results:'+results);
        //handleSaveResults(results,dsList);
    }
    
    public static List<MetadataService.SaveResult> insertDataInCustomField(List<DataStructure> dsList, MetadataService.MetadataPort service,String checkStr)
    {
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        Integer count=0;
        List< MetadataService.Metadata> customFieldList=new  List< MetadataService.Metadata>();
        try{
            for(DataStructure ds:dsList)    
            {
                MetadataService.CustomField customField = new MetadataService.CustomField();
                
                if(checkStr.equalsIgnoreCase('CREATE') || checkStr.equalsIgnoreCase('UPDATERequired'))                
                    customField.type_x = ds.fieldType;
                else if(checkStr.equalsIgnoreCase('UPDATE'))
                    customField.type_x = ds.changedDataType;
                
                customField.label = ds.fieldLabel;
                    
                if(ds.fieldName.endsWithIgnoreCase('__c'))
                    customField.fullName = ds.objectName+'.'+ds.fieldName;
                else
                    customField.fullName = ds.objectName+'.'+ CSVReaderHelperClass.getCorrectFieldName(ds, ds.fieldName);
                
                if(ds.length!=null && ds.dataTypeContainsPrecisionField.contains(customField.type_x))
                    customField.precision=Integer.valueOf(ds.length);
                else if(ds.length!=null)                
                    customField.length=Integer.valueOf(ds.length);                 
                
                if(ds.decimalPlace!=null)                  
                    customField.scale = Integer.valueOf(ds.decimalPlace) ;
                
                if(ds.visibleLines!=null)
                    customField.visibleLines = Integer.valueOf(ds.visibleLines);
                
                if(customField.type_x=='Picklist' || customField.type_x=='MultiselectPicklist')                    
                    customField=createPicklist(customField,ds);
                
                if(ds.fieldDefaultValue!=null)                
                    customField.defaultValue=ds.fieldDefaultValue;
                
                if(ds.required!=null)                
                    customField.required = ds.required;
                
                if(ds.trackFeedHistory !=null)
                {
                    //System.debug('@@@@@@@@'+ds.trackFeedHistory);
                    customField.trackHistory = ds.trackFeedHistory ;
                    //System.debug('@@@@@@@@'+customField.trackFeedHistory);
                }
                    
                
                if(ds.unique!=null)
                { 
                    customField.unique = ds.unique;
                }
                if(customField.type_x=='Lookup')
                {
                    createLookupField(ds, customField);
                } 
                
                if(ds.externalId!=null)
                    customField.unique = ds.externalId;
                
                customField.description=ds.description;
                customField.inlineHelpText=ds.helpText;
                
                if(checkStr.equalsIgnoreCase('UPDATERequired'))
                    customField.required = false;
                
                customFieldList.add(customField);
                if(count<(ApexLimitConstants.maxParameter-1))
                {
                    count++;  
                }
                else
                {
                    count=0;
                    if(checkStr.equalsIgnoreCase('CREATE'))
                        results.addAll(service.createMetadata(customFieldList));
                    else if(checkStr.equalsIgnoreCase('UPDATE')|| checkStr.equalsIgnoreCase('UPDATERequired'))
                        results.addAll(service.updateMetadata(customFieldList));
                    customFieldList.clear();
                }
            }
            if(customFieldList.size()>0 && !customFieldList.isEmpty())
            {
                if(checkStr.equalsIgnoreCase('CREATE'))
                    results.addAll(service.createMetadata(customFieldList));
                else if(checkStr.equalsIgnoreCase('UPDATE') || checkStr.equalsIgnoreCase('UPDATERequired'))
                    results.addAll(service.updateMetadata(customFieldList));
            }
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,e.getMessage()));
        }
        System.debug(''+results);
        return results;
    }
    public static MetadataService.CustomField createPicklist( MetadataService.CustomField customField, DataStructure ds)
    {        
        Metadataservice.Picklist pt = new Metadataservice.Picklist();
        pt.sorted= ds.picklistSorted;
        String[] picklistValue=ds.picklistValue.split('\n');
        //System.debug('After Split PickListValue:'+picklistValue);
        List<MetadataService.PicklistValue> pickValues=new List<MetadataService.PicklistValue>();
        for(String str:picklistValue)
        {
            metadataservice.PicklistValue pv = new metadataservice.PicklistValue();                   
            pv.fullName = str;
            pv.default_x=false ;
            System.debug(pv);
            pickValues.add(pv);
        }
        pt.picklistValues = pickValues;
        customField.picklist = pt ;
        return customField;        
    }
    
    public static void createLookupField(DataStructure ds, MetadataService.CustomField customField)
    { 
        customField.fullName = customField.fullName;
        customField.label = ds.fieldLabel;
        customField.type_x = ds.fieldType;
        customField.relationshipLabel = ds.relatedListLabel;
        customField.relationshipName = ds.relatedListLabel;
        customField.referenceTo = ds.relatedToObject;        
    }
    
    public static void updateFieldLevelSecurity(List<DataStructure> dsList)
    {
        
        Map<String, List<String>> masterMapForReadOnly=new Map<String,List<String>>();
        Map<String, List<String>> masterMapForVisible=new Map<String,List<String>>();
        List<MetadataService.SaveResult> saveResults= new List<MetadataService.SaveResult>();
        
        masterMapForReadOnly = createMapOfProfileAndField(dsList,'ReadOnly');
        masterMapForVisible = createMapOfProfileAndField(dsList,'Visible');
        System.debug('masterMapForReadOnly:'+masterMapForReadOnly+'\n masterMapForVisible:'+masterMapForVisible);
        
        saveResults.addAll(applyFLS(masterMapForVisible, 'Visible'));
        saveResults.addAll(applyFLS(masterMapForReadOnly, 'ReadOnly'));        
        return;
        
    }
    
    public static List<MetadataService.SaveResult> applyFLS(Map<String, List<String>> mapToUpdate, String checkStr)
    {
        System.debug('Inside applyFLS ');
        MetadataService.MetadataPort service = createService();
        List<MetadataService.SaveResult> saveRes=new  List<MetadataService.SaveResult>(); 
        List<MetadataService.Profile> proList = new List<MetadataService.Profile>();
        Integer profileCount=0;
        for(String key:mapToUpdate.keySet())
        {
            MetadataService.Profile pro = new MetadataService.Profile();
            pro.fullName=key;
            List<String> fieldList=mapToUpdate.get(key);
            
            if(fieldList.size()>0 && !fieldList.isEmpty())
            {
                Integer count=0;
                List<MetadataService.ProfileFieldLevelSecurity> fieldSecList = new List<MetadataService.ProfileFieldLevelSecurity>();              
                for(String str:fieldList)
                {
                    MetadataService.ProfileFieldLevelSecurity fieldSec = new MetadataService.ProfileFieldLevelSecurity();
                    fieldSec.field=str;
                    if(checkStr.equalsIgnoreCase('ReadOnly'))
                    {
                        fieldSec.editable=false;
                        fieldSec.readable=true;
                    }
                    else if(checkStr.equalsIgnoreCase('Visible'))
                    {
                        fieldSec.editable=true;
                        fieldSec.readable=true;
                    }
                    if(count < ApexLimitConstants.maxParameter-1)
                    {
                        count++;
                        fieldSecList.add(fieldSec);
                    }
                    else
                    {
                        count=0;
                        pro.fieldPermissions  = fieldSecList ;
                        fieldSecList.clear(); 
                    }
                }
                if(fieldSecList.size()>0 && !fieldSecList.isEmpty())
                {
                    pro.fieldPermissions  = fieldSecList ;
                }
            }
            
            proList.add(pro);
            if(profileCount<ApexLimitConstants.maxParameter-1)
            {
                profileCount++;
            }
            else
            {
                profileCount=0;
                saveRes.addAll(service.updateMetadata(proList));
                proList.clear();
            }            
        }
        if(proList.size()>0 && !proList.isEmpty())
        {
            saveRes.addAll(service.updateMetadata(proList));
        }
        return saveRes;
        
    }
    
    public static void addFieldToLayout(List<DataStructure> dsList)
    {
        MetadataService.MetadataPort service = createService();
        Map<String, List<DataStructure>> layoutAndFieldMap=new Map<String, List<DataStructure>>();
        // layoutAndFieldMap=createMapOfProfileAndField(dsList,'Layout');
        for(DataStructure ds: dsList)
        {
            if(ds.selectedOptionsForLayoutAssignment != null)
            {
                if(ds.selectedOptionsForLayoutAssignment.size()>0 && !ds.selectedOptionsForLayoutAssignment.isEmpty())
                {
                    
                    for(SelectOption so:ds.selectedOptionsForLayoutAssignment)
                    {
                        String key=ds.objectName+'-'+so.getValue();
                        List<DataStructure> values=new List<DataStructure>();
                        if(layoutAndFieldMap.containsKey(key))
                        {
                            values=layoutAndFieldMap.get(key);
                            values.add(ds);
                            layoutAndFieldMap.put(key, values);
                        }
                        else
                        {
                            values.add(ds);
                            layoutAndFieldMap.put(key, values);
                        }
                    }
                }
            }
        }
        Integer count=0;
        List<string> layoutList=new List<String>();
        List<MetadataService.Metadata> layoutMetadata=new List<MetadataService.Metadata>();
        
        for(String str:layoutAndFieldMap.keySet())
        {
            if(count<ApexLimitConstants.maxParameter-1)
            {
                layoutList.add(str);
            }
            else
            {
                count=0;
                layoutList.add(str);	
                //layoutMetadata.addAll(service.readMetadata('Layout',layoutList).records);
                layoutList.clear();
            }
            
        }
        if(layoutList.size()>0 && !layoutList.isEmpty())
        {
            layoutMetadata.addAll(service.readMetadata('Layout',layoutList).getRecords());
        }
        List<MetadataService.SaveResult> saveRes=new  List<MetadataService.SaveResult>();
        List<MetadataService.Layout> layouts=new  List<MetadataService.Layout>(); 
        Integer layoutCount=0;
        try{
            for(MetadataService.Metadata metadata:layoutMetadata)
            {
                MetadataService.Layout layout =(MetadataService.Layout) metadata;
                if(layout.layoutSections==null)
                    layout.layoutSections = new List<MetadataService.LayoutSection>();
                
                MetadataService.LayoutSection layoutSection = layout.layoutSections[0];               
                MetadataService.LayoutColumn layoutColumn = layoutSection.LayoutColumns[0];
                List<MetadataService.LayoutItem> layoutItemList = layoutColumn.layoutItems;
                Set<String> fieldsAlreadyOnLayout=new Set<String>();
                for(MetadataService.LayoutItem item:layoutItemList)
                {
                    fieldsAlreadyOnLayout.add(item.field);
                }
                System.debug('fieldsAlreadyOnLayout:'+fieldsAlreadyOnLayout);
                for(DataStructure ds:layoutAndFieldMap.get(layout.fullName))
                {
                    if(!fieldsAlreadyOnLayout.contains(ds.fieldName))
                    {
                        MetadataService.LayoutItem layoutItem = new MetadataService.LayoutItem();
                        layoutItem.field=ds.fieldName;
                        layoutColumn.layoutItems.add(layoutItem);
                    }
                }
                if(layoutCount<ApexLimitConstants.maxParameter-1)
                {
                    layouts.add(layout);
                }
                else
                {
                    layoutCount=0;
                    layouts.add(layout);
                    saveRes.addAll(service.updateMetadata(layouts));
                    layouts.clear();
                } 
            }
            if(layouts.size()>0 && !layouts.isEmpty())
            {
                saveRes.addAll(service.updateMetadata(layouts));
            }
        }
        Catch(Exception e)
        {
            System.debug('Error'+e);
        }
        System.debug('Map:'+layoutAndFieldMap);
        for(MetadataService.SaveResult sr:saveRes)
            System.debug('saveRes:'+sr);
        
    }
    
    public static List<MetadataService.DeleteResult> deleteField(List<DataStructure> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<String> fieldsToDelete=new List<String>(); 
        for(DataStructure ds:dsList)
        {
            fieldsToDelete.add(ds.objectName+'.'+ds.fieldName);
        }
        try{
            List<String> tempStr=new List<String>();
            Integer tempCount=0;
            for(String str:fieldsToDelete)
            {
                System.debug('String:'+str);
                
                if(tempCount<ApexLimitConstants.maxParameter-1)
                {
                    tempCount++;
                    tempStr.add(str);
                }
                else{
                    tempCount=0;
                    tempStr.add(str);
                    deleteResult.addAll(service.deleteMetadata('CustomField',tempStr));
                    tempStr.clear();
                }
            }
            if(tempStr.size()>0 && !tempStr.isEmpty())
                deleteResult.addAll(service.deleteMetadata('CustomField',tempStr));
            System.debug('***********'+deleteResult);
            
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            System.debug('Exception:'+e);
        }
        return deleteResult;   
    }
    
    public static List<MetadataService.DeleteResult> deleteCustomLabel(List<CustomLabelDS> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<String> labelsToDelete=new List<String>(); 
        for(CustomLabelDS ds:dsList)
        {
            labelsToDelete.add(ds.labelName);
        }
        try{
            List<String> tempStr=new List<String>();
            Integer tempCount=0;
            for(String str:labelsToDelete)
            {
                System.debug('String:'+str);
                
                if(tempCount<ApexLimitConstants.maxParameter-1)
                {
                    tempCount++;
                    tempStr.add(str);
                }
                else{
                    tempCount=0;
                    tempStr.add(str);
                    deleteResult.addAll(service.deleteMetadata('CustomLabel',tempStr));
                    tempStr.clear();
                }
            }
            if(tempStr.size()>0 && !tempStr.isEmpty())
                deleteResult.addAll(service.deleteMetadata('CustomLabel',tempStr));
            //System.debug('***********'+deleteResult);
            
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            System.debug('Exception:'+e);
        }
        return deleteResult;   
    }
    
    public static Set<String> fetchAllProfile()
    {
        Set<String> profileSet=new Set<String>();
        MetadataService.MetadataPort service = createService();
        System.debug('@service'+service);
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryProfile = new MetadataService.ListMetadataQuery();
        queryProfile.type_x = 'ListView';
        queries.add(queryProfile);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        System.debug(fileProperties[0]);
        for(MetadataService.FileProperties fileProperty : fileProperties)
        {
            System.debug(fileProperty.fullName);
            profileSet.add(fileProperty.fullName);
        }
        return profileSet;
    }
    
    public static Set<String> fetchAllTranslations()
    {
        Set<String> translations=new Set<String>();
        MetadataService.MetadataPort service = createService();     
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryProfile = new MetadataService.ListMetadataQuery();
        queryProfile.type_x = 'Translations';
        queries.add(queryProfile);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        for(MetadataService.FileProperties fileProperty : fileProperties)
        {
            translations.add(fileProperty.fullName);
        }
        return translations;
    }
    
    public List<CustomLabelDS> fetchAllLabels()
    {
        List<String> labels=new List<String>();
        List<CustomLabelDS> results=new List<CustomLabelDS>();
        //List<List<String>> newNames=new List<List<String>>();
        MetadataService.MetadataPort service = createService();     
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryLabel = new MetadataService.ListMetadataQuery();
        queryLabel.type_x = 'CustomLabel';
        queries.add(queryLabel);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 30);
        //System.debug(fileProperties[0]);
        for(MetadataService.FileProperties fileProperty : fileProperties)
        {
            //System.debug(fileProperty.fullName);
            labels.add(fileProperty.fullName);
            //labels.add(fileProperty.value);
        }    
        List<MetadataService.IReadResult> rmdList=new List<MetadataService.IReadResult>();
        	try{
            List<String> tempStr=new List<String>();
            Integer tempCount=0;
            for(String str:labels)
            {
                //System.debug('String:'+str);
                
                if(tempCount<ApexLimitConstants.maxParameter-1)
                {
                    tempCount++;
                    tempStr.add(str);
                }
                else{
                    tempCount=0;
                    tempStr.add(str);
                    rmdList.add(service.readMetadata('CustomLabel',tempStr));
                    tempStr.clear();
                }
            }
            if(tempStr.size()>0 && !tempStr.isEmpty())
                rmdList.add(service.readMetadata('CustomLabel',tempStr));
            //System.debug('***********'+deleteResult);
            
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            System.debug('Exception:'+e);
        }
               /* List<String> temp=new List<String>();
                for(Integer i=0;i<labels.size();i++)
                {
                    if(math.mod(i,10)!=0)
                    {
                        temp.add(labels.get(i));
                    }
                    else
                    {
						newNames.add(temp);
                        temp.clear();
                    }
                }
            
        		for(List<String> temp1: newNames)
                {*/
        		for(MetadataService.IReadResult rmd: rmdList)
                { //MetadataService.IReadResult rmd= service.readMetadata('CustomLabel',labels);
                //System.debug('hello');
            
                MetadataService.ReadCustomLabelResult moh=(MetadataService.ReadCustomLabelResult)rmd;
                MetadataService.Metadata[] records= moh.getRecords();
                List<MetadataService.CustomLabel> newRecords= new List<MetadataService.CustomLabel>();
                
                for(MetadataService.MetaData record: records)
                {
                    newRecords.add((MetadataService.CustomLabel)record);
                    
                }
                
                for(MetadataService.CustomLabel label: newRecords)
                {
                    CustomLabelDS lbl=new CustomLabelDS();
                    lbl.shortDesc=label.shortDescription;
                    lbl.categories=label.categories;
                    lbl.labelName=label.fullName;
                    lbl.labelProt=String.valueOf(label.protected_x);
                    lbl.labelValue=label.value;
                    results.add(lbl);
                    
                   //System.debug(label.categories);
                }
                }
              //  }
                //System.debug(newRecords);
                //System.debug(results);
                return results;
    }
    
    public static List<CustomLabelDS> fetchTranslations()
    {
        List<String> labels=new List<String>();
        List<CustomLabelDS> results=new List<CustomLabelDS>();
        MetadataService.MetadataPort service = createService();     
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryLabel = new MetadataService.ListMetadataQuery();
        queryLabel.type_x = 'CustomLabelTranslation';
        queries.add(queryLabel);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        System.debug(fileProperties[0]);
        for(MetadataService.FileProperties fileProperty : fileProperties)
        {
            System.debug(fileProperty.fullName);
            labels.add(fileProperty.fullName);
            //labels.add(fileProperty.value);
        }       
        MetadataService.IReadResult rmd = service.readMetadata('CustomLabel',labels);
        MetadataService.ReadCustomLabelResult moh=(MetadataService.ReadCustomLabelResult)rmd;
        MetadataService.Metadata[] records= moh.getRecords();
        List<MetadataService.CustomLabel> newRecords= new List<MetadataService.CustomLabel>();
        
        for(MetadataService.MetaData record: records)
        {
            newRecords.add((MetadataService.CustomLabel)record);
            
        }
        
        for(MetadataService.CustomLabel label: newRecords)
        {
            CustomLabelDS lbl=new CustomLabelDS();
            lbl.shortDesc=label.shortDescription;
            lbl.categories=label.categories;
            lbl.labelName=label.fullName;
            lbl.labelProt=String.valueOf(label.protected_x);
            lbl.labelValue=label.value;
            results.add(lbl);
            
            //System.debug(label.categories);
        }
        //System.debug(newRecords);
        return results;
    }
    public static void fetchTrackFeedHistory(List<DataStructure> dsList)
    {
        Set<String> objectSet = new Set<String>();
        List<String> objectList=new List<String>();
        for(DataStructure ds: dsList)
        {
            objectSet.add(ds.objectName);
        }
        objectList.addAll(objectSet);
                
        Map<String,Schema.SObjectField> objectAndFieldsMap;
        
        Schema.DescribeSObjectResult[] objectResult = Schema.describeSObjects(objectList);
                
			for(Schema.DescribeSObjectResult res: objectResult)
            {
                objectAndFieldsMap=res.fields.getMap();
                System.debug('objectAndFieldsMap11111-------@@@@@@@ ' + objectAndFieldsMap);
                
                
            }        
        map<String, Schema.SObjectField> FieldMap = Schema.SObjectType.Contact.fields.getMap();
        for (Schema.SObjectField f : FieldMap.values()) {
            Schema.DescribeFieldResult DescField = f.getDescribe();
            system.debug('333333333Name: ' +  DescField.getName());
            system.debug('333333333Type: ' +  DescField.getType());
        }
        System.debug('objectAndFieldsMap22222-------@@@@@@@'+objectAndFieldsMap);
    }
    
    
    public static Map<String, List<String>> fetchAllLayouts()
    {
        Map<String, List<String>> objectLayoutMap=new  Map<String, List<String>>();
        
        MetadataService.MetadataPort service = createService();     
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryLayout = new MetadataService.ListMetadataQuery();
        queryLayout.type_x = 'Layout';
        queries.add(queryLayout);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        System.debug(fileProperties[0]);
        for(MetadataService.FileProperties fileProperty : fileProperties)
        {
            List<String> tempStrList=new List<String>();
            tempStrList=fileProperty.fullName.split('-');
            //System.debug(tempStrList);
            List<String> valueOfMap=new LIST<String>();
            if(objectLayoutMap.containsKey(tempStrList[0]))
            {                
                valueOfMap = objectLayoutMap.get(tempStrList[0]);
                valueOfMap.add(tempStrList[1]);
            }
            else
            {
                valueOfMap.add(tempStrList[1]);
            }
            objectLayoutMap.put(tempStrList[0], valueOfMap);   
        }
        return objectLayoutMap;
        //System.debug('Map:'+objectLayoutMap);
        
    }
    
    public static Map<String, List<String>> createMapOfProfileAndField(List<DataStructure> dsList, String key)
    {
        System.debug('Inside createMapOfProfileAndField');
        List<SelectOption> soList=new List<SelectOption>();
        Map<String, List<String>> mapOfProfileAndField=new Map<String, List<String>>();
        for(DataStructure ds: dsList)
        {
            String fieldName;
            if(key.equalsIgnoreCase('ReadOnly'))
            {
                soList=ds.selectedOptionsForReadOnly;
                fieldName=ds.objectName+'.'+ds.fieldName;
            }
            else  if(key.equalsIgnoreCase('Visible'))
            {
                soList=ds.selectedOptionsForVisibleOnly;
                fieldName=ds.objectName+'.'+ds.fieldName;
            }            
            if(soList.size()>0 && !soList.isEmpty())
            {
                for(SelectOption so: soList)
                {
                    
                    List<String> tempList=new List<String>();
                    if(mapOfProfileAndField.containsKey(so.getValue()))
                    {
                        tempList=mapOfProfileAndField.get(so.getValue());
                        tempList.add(fieldName);
                        mapOfProfileAndField.put(so.getValue(), tempList);
                    }
                    else
                    {
                        tempList.add(fieldName);
                        mapOfProfileAndField.put(so.getValue(), tempList);
                    }
                    
                }
            }
        }
        return mapOfProfileAndField;
    }
    
    public static void handleSaveResults(List<MetadataService.SaveResult> saveResults,List<DataStructure> dsList)
    {
        System.debug('Inside handleSaveResults:'+saveResults.size()+' '+dsList.size());
        Integer count=0;
        for(MetadataService.SaveResult saveResult:saveResults)
        {
            if(saveResult==null || saveResult.success)
            {
                dsList[count].errorMsg=null;
                
                dsList[count].result='Success';
                
            }
            if(saveResult.errors!=null)
            {
                dsList[count].result='error';
                List<String> messages = new List<String>();               
                for(MetadataService.Error error : saveResult.errors)
                    messages.add(error.message);
                if(messages.size()>0)
                {
                    dsList[count].errorMsg=String.join(messages, ' '); 
                    //throw new MetadataExampleFieldCreationException(String.join(messages, ' '));
                }               
            }
            else{
                if(!saveResult.success)
                {
                    dsList[count].result='error';
                    dsList[count].errorMsg='Request failed with no specified error.';
                    //throw new MetadataExampleFieldCreationException('Request failed with no specified error.');
                }
                
            }
            count++;
        }
    }
    
    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    public class MetadataExampleFieldCreationException extends Exception { }
    
    public static List<MetadataService.SaveResult> createCustomLabel(LIST<CustomLabelDS> dsList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        results=insertDataInCustomLabel(dsList,service);
        return results;
    }
    
    public static List<MetadataService.SaveResult> insertDataInCustomLabel(List<CustomLabelDS> dsList, MetadataService.MetadataPort service)
    {
        List<MetadataService.SaveResult> results=new List<MetadataService.SaveResult>();
        Integer count=0;
        List< MetadataService.Metadata> customLabelList=new  List< MetadataService.Metadata>();
        try
        {
            for(CustomLabelDS ds:dsList)    
            {
                System.debug(ds.labelName);
                System.debug(ds.categories);
                System.debug(ds.labelProt);
                System.debug(ds.shortDesc);
                System.debug(ds.labelValue);
                MetadataService.CustomLabel customLabel = new MetadataService.CustomLabel();
                if(ds.labelName!=null)
                customLabel.fullName = ds.labelName;
                if(ds.categories!=null)
                customLabel.categories = ds.categories;
                if(ds.labelProt!=null)
                customLabel.protected_x = Boolean.valueOf(ds.labelProt);
                if(ds.shortDesc!=null)
                customLabel.shortDescription = ds.shortDesc;
                if(ds.labelValue!=null)
                customLabel.value = ds.labelValue;
                customLabel.language = ds.language;
                	
                customLabelList.add(customLabel);
                if(count<(ApexLimitConstants.maxParameter-1))
                {
                    count++;  
                }
                else
                {
                    count=0;
                    results.addAll(service.createMetadata(customLabelList));
                    customLabelList.clear();
                }
            }
            
            if(customLabelList.size()>0 && !customLabelList.isEmpty())
            {
                results.addAll(service.createMetadata(customLabelList));
            }
            System.debug(results);
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING,e.getMessage()));
        }
        return results;
    }

    public static void createTranslationsForCustomLabels(String labelName,String lang,String labelTranslation)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomLabelTranslation clt = new MetadataService.CustomLabelTranslation();
		clt.label=labelTranslation;
		clt.name =labelName;
        MetadataService.Translations trans = new MetadataService.Translations();
		trans.customLabels = new MetadataService.CustomLabelTranslation[] { clt };
		trans.fullName     = lang;
		trans.type = 'Translations';
        
        List<metadataservice.saveresult> resultsT = service.createMetadata(new MetadataService.Metadata[] { trans });       
		//handleSaveResults(resultsT[0]);
    }
        
    
}