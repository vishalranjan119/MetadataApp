/*
* 
* 
* 
* 
* 
* 
*
*/ 
public class CSVReader  {
    
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    private List<DataStructure> dsList=new LIST<DataStructure>();
    private List<DataStructure> successList = new List<DataStructure>();
    private List<DataStructure> errorList = new List<DataStructure>();
    private List<DataStructure> completeList = new List<DataStructure>();
    public LIST<SelectOption> dataTypeList=new LIST<SelectOption>();   
    public List<SelectOption> dataTypeOptions=new LIST<SelectOption>();
    public List<SelectOption> allSobjects = new List<SelectOption>();
    public List<selectoption> selectedReadOnlyList{get;set;}
    public List<selectoption> selectedVisibleList{get;set;}
    public List<selectoption> profileList{get;set;}
    public Boolean isObjectNameEditable{get;set;}
    public Boolean isRenderErrorResult{get;set;}
    public Boolean showDownloadFilesButton{get;set;}
    public Boolean isCancelCalled=false;
    public Boolean validationCompleteLabel{get;set;}
    public Boolean disableSubmitAndCancelBtnOnReviewPage{get;set;}
    public Boolean hideSubmitSection{get;set;}
    public Boolean showErrorColumns{get;set;}
    public Boolean hideExtraColumnsAfterFinalSubmit{get;set;}    
    public Boolean showApplyToAllPopUp{get;set;}
    public Boolean isgetdataTypeOptions=false;
    public Boolean isgetallSobjectsCalled = false;
    public Boolean isCreateFieldCalled=false;   
    public Boolean checkboxStateForReadonly{get;set;}
    public Boolean checkboxStateForVisible{get;set;}
    public Boolean displayModal{get;set;}
    public Integer successListSize{get;set;}
    public Integer errorListSize{get;set;}
    CSVReaderHelperClass helper = new CSVReaderHelperClass();
    public List<String> tableHeader{get;set;}
    public Boolean isRenderExtraCol{get;set;}
    /*****************************************************************************************************************************************************/   
    public CSVReader(){
        displayModal= false;
        isRenderExtraCol = false;
        isCancelCalled=false;
        isRenderErrorResult=false;
        selectedVisibleList = new List<selectOption>();
        selectedReadOnlyList = new List<selectOption>();
        tableHeader = new List<String>{'','S.No.', 'Object Name','Data Type', 'Label','Field Name', 'Length', 'Decimal Places', 
            'Visible Lines','Picklist Values','Picklist Sorted','Default Value','Required','Track Feed History','ExternalId','Unique',
            'Related To Object','Child Relationship Name','Related List Label','Description','Help Text'}; 
    }
  /**
	* @desc: read CSV file and create data structure for each row
	* @param:  
	* @return: Pagereference - Edit page
    */
    public Pagereference ReadFile(){           
        try
        {           
            PageReference editPage = goToEditPage();
            
            nameFile=contentFile.toString();                
            String[] inputValues=nameFile.split('\n');                 
            dsList=helper.createStructure(inputValues);
            profileList = new List<SelectOption>();
            if(dsList.size() >0 && !dsList.isEmpty()){
                profileList = helper.createStructureForFLS();
                
            }
            //editPage.setRedirect(true);
            return editPage;
        }
        catch(Exception e)
        {
            System.debug('****error****'+e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Upload a File')); 
            return null;
        }
    }
    
  /**
	* @desc: when skip button clicked on main page it transfer us to edit to page to create field.
	* @param:
	* @return: Pagereference - Edit page
    */    
    public Pagereference onSkip(){
        dsList.clear();
        PageReference editPage = goToEditPage();
        profileList = helper.createStructureForFLS();
        return editPage;
    }
  /**
	* @desc: On Submit paas data to MetadataApi Class to create Fields, Apply FLS, and add to PageLayout.
	* @param:
	* @return: Pagereference - null
    */ 
    public PageReference createField()
    {
        isCreateFieldCalled=true;
        isObjectNameEditable=true;
        showDownloadFilesButton=true;
        isRenderExtraCol = true;	        
     
        MetadataApi.createField(dsList);
        MetadataApi.updateFieldLevelSecurity(dsList);
        MetadataApi.addFieldToLayout(dsList);                       
        for(DataStructure ds: dsList){
            completeList.add(ds);
            
            if(ds.result=='Success'){
                successList.add(ds);
            }
            else if(ds.result=='error'){
                errorList.add(ds);
            }
            
        }
        System.debug('completeList@@@'+completeList);
        successListSize=successList.size();
        errorListSize=errorList.size();
        return null;
    }   
  /**
	* @desc: on changing the data type on edit page this method changes the display according to changed data type.
	* @param:
	* @return: void
    */ 
    public void changeStructure(){
        helper.createStructureForLayoutAssignment(this.dsList);
        for(DataStructure ds: dsList){
            if(ds.fieldType != ds.changedDataType){
                ds.fieldType = ds.changedDataType;
                UtilityClass.changeStructure(ds);
            }
        }
    }
  /**
	* @desc: After changing the data type option to back on initial state.
	* @param:
	* @return: PageReference- return on same page.
    */ 
    public PageReference initialState(){
        for(DataStructure ds:dsList){
            //if(ds.isUpdatable){
                if(ds.changedDataType != ds.fieldType){
                    ds.changedDataType=ds.fieldType;
                }
            //}
        }
        return null;
    }
    
  /**
	* @desc: Apply same FLS(Readonly) to all fields
	* @param:
	* @return: void
    */
    public void applyReadonlyToAllProfiles(){ 
        List<SelectOption> listFirstSelectedProfile=new List<SelectOption>();
        listFirstSelectedProfile=dsList[0].selectedOptionsForReadOnly;
        for(Integer i = 1; i < dsList.size(); i++){
            DataStructure ds = dsList.get(i);
            ds.selectedOptionsForReadOnly.clear();
            ds.selectedOptionsForReadOnly.addAll(listFirstSelectedProfile);
        }       
    }
  /**
	* @desc: Apply same FLS(Visible) to all fields
	* @param:
	* @return:
    */    
    public void applyVisibleToAllProfiles(){
        List<SelectOption> listFirstSelectedProfile=new List<SelectOption>();
        listFirstSelectedProfile=dsList[0].selectedOptionsForVisibleOnly;
        for(Integer i = 1; i < dsList.size(); i++){
            DataStructure ds = dsList.get(i);
            ds.selectedOptionsForVisibleOnly.clear();
            ds.selectedOptionsForVisibleOnly.addAll(listFirstSelectedProfile);
        }  
    }
  /**
	* @desc: add new fields on edit page with some defaul value.
	* @param:
	* @return: PageReference - returns on same page
    */
    public PageReference addNewRowInTable(){
        Map<String, List<String>> objectLayoutMap=new  Map<String, List<String>>();
        DataStructure ds=new DataStructure();
        ds.objectName = 'Account';
        ds.changedDataType = 'Checkbox';
        ds.fieldType = 'Checkbox';
        ds.selectedOptionsForLayoutAssignment = new List<Selectoption>();
        ds.selectedOptionsForReadOnly = new List<Selectoption>();
        ds.selectedOptionsForVisibleOnly = new List<Selectoption>();
        helper.createStructureForLayoutAssignment(new List<DataStructure>{ds});
        ds.allOptionsForReadOnly = helper.createStructureForFLS();
        ds.allOptionsForVisibleOnly =helper.createStructureForFLS();
        UtilityClass.changeStructure(ds);
        isObjectNameEditable=false;
        dsList.add(ds);
        return null;
    }
  /**
	* @desc: delete a particulor row on clicking the delete link available on first column.
	* @param:
	* @return: PageReference - returns on same page
    */
    
    public PageReference onClickDelete(){
        Integer index = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        List<DataStructure> dsToRemove = new List<DataStructure>();
        if(dsList[index-1] != null){
            System.debug('@DS***:'+dsList[index-1].fieldType);
            dslist.remove(index-1);
        }
        //PageReference pageref = new PageReference('/apex/MetaDataPageUITest');
        return null;
    }
  /**
	* @desc: get all field type's available for field creation and return it to the VF Page. 
	* @param:
	* @return: List<SelectOption> - List of field type  
    */
    
    public  List<SelectOption> getdataTypeOptions(){
        if(!isgetdataTypeOptions){
            dataTypeOptions = UtilityClass.getAllFieldType();
            isgetdataTypeOptions=true;
        }
        return dataTypeOptions;
    } 
  /**
	* @desc: get all objects available for field creation and return it to the VF Page.  
	* @param:
	* @return: List<SelectOption> - List of sObjects 
    */
    public List<SelectOption> getallSobjects(){      
        if(!isgetallSobjectsCalled){
            allSobjects = UtilityClass.getAllSObject();
            isgetallSobjectsCalled = true;
        }
        if(allSobjects.size() > 0)
            return allSobjects;
        else 
            return null;
    }
  /**
	* @desc: return data structure list to VF Page.
	* @param:
	* @return: List<DataStructure> - List of DataStructure
    */    
    public List<DataStructure> getdsList(){
        if (dsList!= NULL) {
            if (dsList.size() > 0)
                return dsList;
            else
                return null;  
        }                   
        else
            return null;
        
    }
  /**
	* @desc: return the Boolean value to the VF page, CreateField method is called or not 
	* @param:
	* @return: Boolean
    */    
    public Boolean getisCreateFieldCalled(){
        return isCreateFieldCalled;
    }
  /**
	* @desc: validate data of CSV File, if some garbage data display an error message on page. 
	* @param:
	* @return:
    */    
    public void validate(){
        MetadataApi.fetchTrackFeedHistory(dsList);
        Boolean isValidationComplete=Validatedata.validateDataBeforeSubmit(dsList);
        for(DataStructure ds: dsList){
            if(ds.picklistValue!=null && ds.picklistValue!=''){
                System.debug('character picklist values length@@'+ ds.picklistValue.trim().length());
                System.debug('ds.picklistValue@@'+ds.picklistValue);
                System.debug('ds.picklistValues@@@@@'+ds.picklistValues);
                //       ds.picklistValue.replace(' ','$%^');
            }
        }
        if(ValidateData.validateDataBeforeSubmit(dsList)){
            if(isValidationComplete){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No Validation Error. Please proceed to create fields.')); 
        }
        }
        
    }
  /**
	* @desc: 
	* @param:
	* @return:
    
    public PageReference ignoreErrorsAndSubmit(){
        hideSubmitSection=true;
        validationCompleteLabel=false;
        hideExtraColumnsAfterFinalSubmit=true;
        PageReference reviewPage=new pageReference('/apex/ReviewMetadataDemo');
        return reviewPage;
    }*/
  /**
	* @desc: create excel File of all the fields.
	* @param:
	* @return: pageReference: downladable Excel file
    */    
    public pageReference ExportDataInCSVFile(){
        PageReference exExtractAllData = Page.ExcelAllDataDownload; 
        exExtractAllData.setRedirect(false);
        for(DataStructure ds: dsList){
            completeList.add(ds);
        } 
        System.debug('completeList@@@@@@@'+completeList);
        if(ValidateData.validateFieldLabelnName(dsList)){
            return exExtractAllData;
        }          	
        return null;
    }
  /**
	* @desc: create excel File of successfully created fields.
	* @param:
	* @return: pageReference: downladable Excel file
    */    
    public pageReference DownloadSuccessExcel(){
        PageReference exDownloadSuccess = null;
        exDownloadSuccess = Page.ExcelDownload;
        exDownloadSuccess.setRedirect(false);
        successList.clear();
        for(DataStructure ds: dsList){
            if(ds.result=='Success'){
                successList.add(ds);
            }
        }
        if(successList.size()>0)
           return exDownloadSuccess;
        else{
            return null;
        }             
    }
  /**
	* @desc: create excel file for fields in which have some error during the creation of fields.
	* @param:
	* @return: pageReference: downladable Excel file
    */
    public pageReference DownloadErrorExcel(){
        PageReference exDownloadError = null;
        exDownloadError = Page.ExcelDownloadError;
        exDownloadError.setRedirect(false);
        errorList.clear();       
        for(DataStructure ds: dsList){
            if(ds.result=='error'){
                errorList.add(ds);
            }
        }
        return exDownloadError;
    }
  /**
	* @desc: get excel files of successfully creates fields, all fields and in which have some error.  
	* @param:
	* @return: List<DataStructure> - list of DataStructure
    */
    public List<DataStructure> getsuccessList(){
        return successList;
    }
    public List<DataStructure> getcompleteList(){
        return completeList;
    }
    public List<DataStructure> geterrorList(){
        return errorList;
    }
  /**
	* @desc: 
	* @param:
	* @return:
    */
    public void applyFLSToAll(){
        system.debug('Here in applyFLSToAll');
        for(DataStructure ds:dsList)
        {
            ds.selectedOptionsForReadOnly.clear();
            if(ds.applyFlS){
                ds.selectedOptionsForReadOnly.addAll(selectedReadOnlyList);
                //ds.allOptionsForReadOnly.addAll(allPofileReadOnlylist);
                ds.selectedOptionsForVisibleOnly.addAll(selectedVisibleList);
                //ds.allOptionsForVisibleOnly.addAll(allPofileVisibleList);
                
            }
            
        }
    }
  /**
	* @desc: return to the different page according to the button click event on VF Page
	* @param:
	* @return: PageReference
    */
    public PageReference goToFileUploadPage(){
        isRenderExtraCol = false;
        PageReference fileuploadPage = new pageReference('/apex/MainFileUploadPageNEW_tarun');
        return fileuploadPage;
    }
    public PageReference goToEditPage(){
        displayModal = false;
        PageReference editPage = new PageReference('/apex/MetadataDemoPageNEW_tarun');
        return editPage;
    }
      
    public void goToFLSAssignmentPage(){
        displayModal = true;
        /*if(ValidateData.validateFieldLabelnName(dsList)){
            PageReference flsAssignmentPage = new pageReference('/apex/FieldLevelSecurityAssignmentPage_SLDS');
        	return flsAssignmentPage;
        }*/
       	        
    }
    public void hideFLSModal(){
         displayModal = false;
    }
    public PageReference goTopageLayoutAssignmentPage(){
        dsList=helper.createStructureForLayoutAssignment(dsList);
        PageReference pageLayoutAssignmentPage = new pageReference('/apex/PageLayoutAssignmentPage_slds');
        return pageLayoutAssignmentPage;
    }
    public PageReference goToReviewPage(){
        System.debug('#########'+ValidateData.validateFieldLabelnName(dsList));
        if(ValidateData.validateFieldLabelnName(dsList)){
            PageReference pageLayoutAssignmentPage = new pageReference('/apex/ReviewPage_slds');
            return pageLayoutAssignmentPage;
        }
        return null;
    }
}