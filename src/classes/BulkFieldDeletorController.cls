public class BulkFieldDeletorController {
    
    private  Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    private  List<SelectOption> objNames = new List<SelectOption>();
    public  String selectedObject{get;set;}
    public  List<DataStructure> dsList{get;set;}
    public  List<DataStructure> dsListToDelete{get;set;}
    private Boolean isgetObjCalled=false;
    private Boolean isgetdsListCalled=false;
    private  String pageBlockSectionTitle{get;set;}
    public Boolean isObjectSelected{get;set;}
    public Boolean clearPreviousRecords{get;set;}
    public Boolean hideAfterDeletion{get;set;}
    public  List<DataStructure> dsList2{get;set;}//=new LIST<DataStructure>();
    private Boolean isCancelCalled = false;
    public integer i {get;set;}
    private String fieldAPIName;
    public Integer total {get; set;}
    public String convertCountValueToInteger;
    public Boolean goToDeletePage{get;set;}
    public Boolean showDownloadFilesButton{get;set;}
    private List<DataStructure> successList = new List<DataStructure>();
    private List<DataStructure> errorList = new List<DataStructure>();
    public Integer successListSize{get;set;}
    public Integer errorListSize{get;set;}
    public Boolean showErrorColumn{get;set;}
    public String fetchLastModifiedDate{get;set;}
    public List<AggregateResult> obj{get;set;}
    public Boolean isAnalysed{get;set;}
    public Boolean isDeleted{get;set;}
    
    public BulkFieldDeletorController(){
        dsListToDelete=new LIST<DataStructure>();
        dsList = new LIST<DataStructure>();
        isDeleted = false; 
    }
    public PageReference createObjSelectOption()
    {
        System.debug('Inside createObjSelectOption');
        isgetdsListCalled=false;
        clearPreviousRecords=true;
        showErrorColumn=false;
        isAnalysed=false;
        hideAfterDeletion=true;
        objNames.addAll(UtilityClass.getAllSObject());
        System.debug('showErrorColumn@@@'+showErrorColumn);        
        return null;
    }
    
    public PageReference goToSecondPage()
    {
        for(DataStructure ds:dsList){
            if(ds.isDeletable){
                dsListToDelete.add(ds);
            }
        }
        if(dsListToDelete.size() > 0 && !dsListToDelete.isEmpty()){
            PageReference secondPage = new PageReference('/apex/BulkFieldDeletorWarningScreen_slds');
            //  PageReference pageRef = ApexPages.currentPage();     
            return secondPage;
        }else{
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Please select a field to delete !!'));
            return null;
        }
     
    }
          
    public void analyseFields()
    {        
        BatchClass b=new BatchClass(dsList, selectedObject);
        ID batchprocessid = Database.executeBatch(b);
        countRecords(dsList);
    }
    
    public PageReference goToFirstPage()
    {
        isDeleted = false;
        dsList.clear();
        dsListToDelete.clear();
        PageReference firstPage = new PageReference('/apex/BulkFieldDeletorNew_tarun');
		firstPage.setRedirect(true);
        return firstPage;
    }
    
    
    public  List<SelectOption> getobjNames() 
    {
        System.debug('getobjNames'+isgetObjCalled);
        if(!isgetObjCalled)
        {
            isgetObjCalled=true;
            createObjSelectOption();
        }
        return objNames;
    }
    
    public PageReference createDataStructur()
    {
        dsList.clear();
        isObjectSelected = true;
        Map<String,Schema.SObjectField> fieldMap=schemaMap.get(selectedObject).getDescribe().fields.getMap();
        System.debug('Fields:'+fieldMap);
       
        for(Schema.SObjectField sfield:fieldMap.values())
        {
            System.debug('Inside Loop sfield@@@'+ sfield);
            DataStructure ds=new DataStructure();
            if(String.valueOf(sfield).contains('__c'))
            {
                System.debug('');
                ds.fieldLabel=sfield.getDescribe().getLabel();
                ds.fieldName=sfield.getDescribe().getLocalName();                
                ds.fieldType=UtilityClass.correctFieldType(String.valueOf(sfield.getDescribe().getType()));
                ds.unique=sfield.getDescribe().isUnique();
                ds.objectName = selectedObject;
                ds.isDeletable=false;
                ds.isEditable=false;
                dsList.add(ds);
         //       ds.fieldType=String.valueOf(sfield.getDescribe().getType());
            }
        }
        
        countRecords(dsList);
        return null;
        //MetadataService.IReadResult readReasult=MetadataApi.readFieldsOfObject(selectedObject);
        //MetadataService.Metadata[] mdinfo=readReasult.getRecords();
    }
    
    public void countRecords(List<DataStructure> dsList)//Map<String,Schema.SObjectField> fieldMap)
    {
        List<Count_Object__c> countObjectList = [Select Id, Name, ObjectAndFieldName__c, Count__c, LastModifiedDate from Count_Object__c where Name =: selectedObject];
        System.debug('countObjectList##'+countObjectList);
        Map<String, Integer> mapOfExternalIdAndFieldCount = new Map<String, Integer>();
        
        if(countObjectList!=NULL && !countObjectList.isEmpty())
        {
            for(Count_Object__c c: countObjectList)
            {
                mapOfExternalIdAndFieldCount.put(c.ObjectAndFieldName__c, Integer.valueOf(c.Count__c));
            }
            for(DataStructure ds: dsList)
            {
                ds.count1= Integer.valueOf(mapOfExternalIdAndFieldCount.get(selectedObject+'.'+ds.fieldName));
            }
        }
        else
        {
            for(DataStructure ds: dsList)
            {
                ds.count1= 0;
            }
        }
        
        if(countObjectList!=NULL && !countObjectList.isEmpty())
        {
            Count_Object__c obj = countObjectList.get(0);
            fetchLastModifiedDate=String.valueOf(obj.LastModifiedDate) ;
        }
    }
    
    public List<DataStructure> getFields()
    {
        System.debug('Inside getFields');        
        return dsList;   
    }
    
    
    public  PageReference deleteSelectedField()
    {        
        System.debug('*****Inside deleteSelectedField*********');
        System.debug('dsListToDelete'+dsListToDelete);
        List<MetadataService.DeleteResult> deleteResultList=MetadataApi.deleteField(dsListToDelete);
        handleDeleteResult(deleteResultList);
        return null;
    }
 
    public void handleDeleteResult(List<MetadataService.DeleteResult> deleteResultList)
    {
        isDeleted = true;
        if(!deleteResultList.isEmpty() && deleteResultList.size()>0)
        {
            System.debug(''+deleteResultList.size());
            Integer delResultCount=0;
            for(DataStructure ds:dsListToDelete)
            {
                if(delResultCount<deleteResultList.size())
                {
                    System.debug('dsFieldName'+ds.fieldName);
                    System.debug('deleteResult'+deleteResultList[delResultCount].fullName);
                    
                    if(deleteResultList[delResultCount]==null || deleteResultList[delResultCount].success)
                    {
                        ds.result='Success';
                     	
                     }
                    
                    if(deleteResultList[delResultCount].errors!=null)
                    {
                        ds.result='Error';
                        
                        List<String> messages = new List<String>();               
                        for(MetadataService.Error error : deleteResultList[delResultCount].errors)
                            messages.add(error.message);
                        if(messages.size()>0)
                        {  ds.errorMsg=(String.join(messages, ' '));
                         
                        }
                        
                    }
                    else{
                        if(!deleteResultList[delResultCount].success)
                            ds.errorMsg='Request failed with no specified error.';
                    }
                }
                
                delResultCount++;
                
                if(ds.result!=NULL && ds.result=='Success')
                {
                    successList.add(ds);
                }
                    
                else if (ds.result!=NULL && ds.result=='Error')
                {
                    errorList.add(ds);
                }
                System.debug('errorList@@'+errorList);
                System.debug('errorList.size()@@'+errorList.size());
                if(errorlist.size()==0)
                {
                    showErrorColumn=true;
                }
               
            }
            System.debug('showErrorColumn@@'+showErrorColumn);
            successListSize=successList.size();
        	errorListSize=errorList.size();
        }
    }
    public pageReference DownloadSuccessExcel(){
        PageReference exDownloadSuccess = null;
        exDownloadSuccess = Page.ExcelDownloadDeleteFieldSuccessResult;
        exDownloadSuccess.setRedirect(false);
      //  successList.clear();
        for(DataStructure ds: dsList){
            if(ds.result=='Success'){
                successList.add(ds);
            }
        } 
        return exDownloadSuccess;
    }

    public pageReference DownloadErrorExcel(){
        PageReference exDownloadError = null;
        exDownloadError = Page.ExcelDownloadDeleteFieldErrorResult;
        exDownloadError.setRedirect(false);
 //       errorList.clear();       
        for(DataStructure ds: dsList){
            if(ds.result=='error'){
                errorList.add(ds);
            }
        }
        return exDownloadError;
    }
    
    public List<DataStructure> geterrorList(){
        return errorList;
    }
    
    public List<DataStructure> getsuccessList(){
        return successList;
    }
        
    public String getpageBlockSectionTitle()
    {
        return pageBlockSectionTitle;
    }
    public Boolean getisgetdsListCalled()
    {
        return isgetdsListCalled;
    }
    
}