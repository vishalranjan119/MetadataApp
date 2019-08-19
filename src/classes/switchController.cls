public class switchController {
    
    public  final String Workflow = 'WorkflowRule';
    public  final String Validation = 'ValidationRule';
    public  final String Triggers = 'ApexTrigger';
    public  Map<string,list<switchStructure>> mapOfElements {get;set;}   
    public  List<SelectOption> options = new List<SelectOption>();
    public List<SelectOption> objNames = new List<SelectOption>();
    public  String selectedType{get;set;}
    public  Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public  String selectedObject{get;set;}
    Public  Boolean iscreateSelectOptionCalled=false;
    Public  Boolean iscreateObjSelectOptionCalled=false;
    Public  Boolean isObjectSelected{get;set;} 
    Public  Boolean isRenderObjectTable{get;set;} 
    Public  Boolean isRenderMetadataTable{get;set;} 
    Public  List<switchStructure> PrintList{get;set;}
    Public  List<switchStructure> workflowPrintList{get;set;}
    Public  List<switchStructure> validationPrintList{get;set;}
    //Public  List<switchStructure> triggerPrintList{get;set;}  
    list<MetadataService.ValidationRule> validationResults =new list<MetadataService.ValidationRule>();
    list<MetadataService.Workflowrule> workflowResults = new list<MetadataService.Workflowrule>();
    
    public PageReference createSelectOption()
    {
        iscreateSelectOptionCalled=true;
        
        System.debug('Inside createObjSelectOption');
        options.add(new SelectOption('Object','Object'));
        //options.add(new SelectOption('Workflow','Workflow Rule'));
        //options.add(new SelectOption('Validation','Validation Rule'));
        //options.add(new SelectOption('Trigger','Triggers'));
        options.add(new SelectOption('Metadata','All Metadata'));
        isObjectSelected=false;
        isRenderObjectTable= false;
        isRenderMetadataTable=false;
        return null;
    }
    public  List<SelectOption> getoptions() 
    {
        if(!iscreateSelectOptionCalled)
            createSelectOption();
        return options;
    }
    
    public PageReference createObjSelectOption()
    {
        iscreateObjSelectOptionCalled=true;
        
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        for(String name : entities)
        {
            objNames.add(new SelectOption(name,name));
        }
        return null;
    } 
    public  List<SelectOption> getobjNames() 
    { 
        if(!iscreateObjSelectOptionCalled)
            createObjSelectOption();
        return objNames;
    }
    
    public PageReference onMainOptionSelect()
    {
        if(selectedType=='Object')
            isObjectSelected=true;
        else
            isObjectSelected=False;
        return NULL;
        
    }
    
    /* Function to get all types of Data in the defined structure */
    public   void  getElementData(){
        
        mapOfElements = new Map<string,list<switchStructure>>();
        list<switchStructure> workflowElements = new list<switchStructure>(); 
        list<switchStructure> validationElements = new list<switchStructure>(); 
        //list<switchStructure> TriggerElements = new list<switchStructure>(); 
        MetadataService.MetadataPort service = MetadataApi.createService();     
        
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        
        MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
        queryWorkflow.type_x = Workflow;
        queries.add(queryWorkflow);        
        
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = Validation;   
        queries.add(queryValidationRule);  
        
        try {
            MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 36);
            list<string> breakName ;
            for(MetadataService.FileProperties fileProperty : fileProperties)
            {
                switchStructure switchObj = new switchStructure ();
                switchObj.FullName = fileProperty.fullName;
                breakName = new list<String>();
                breakName = fileProperty.fullName.split('\\.'); 
                switchObj.ObjectName = breakName[0]; 
                switchObj.ElementName = breakName[1];
                switchObj.Type = fileProperty.type_x;
                if(switchObj.Type==Workflow){
                    //switchObj.MetadataType = switchObj.MetadataType.WORKFLOWRULE;
                    workflowElements.add(switchObj);
                }
                if(switchObj.Type==Validation){
                    //switchObj.MetadataType = switchObj.MetadataType.VALIDATIONRULE;
                    validationElements.add(switchObj);
                }
            }
            mapOfElements.put(Workflow,workflowElements);
            mapOfElements.put(Validation,validationElements);
            
            //List<ApexTrigger> TriggerList = [SELECT Name,Status,TableEnumOrId,Body FROM ApexTrigger];
            /*if(TriggerList.size()>0 && !TriggerList.isEmpty())
            {
                switchStructure switchObj ;
                for(ApexTrigger trig:TriggerList)
                {
                    switchObj = new switchStructure();
                    switchObj.ElementName = trig.Name;
                    switchObj.ObjectName = trig.TableEnumOrId;
                    switchObj.triggerBody=trig.Body;
                    switchObj.Type = Triggers;
                    if(trig.Status=='Active')
                        switchObj.isActive = true;
                    else
                        switchObj.isActive = False;
                }
                TriggerElements.add(switchObj);
            }
            mapOfElements.put(Triggers, TriggerElements);*/ 
            system.debug('mapOfElements : '+mapOfElements);
            //return mapOfElements;
        } catch(exception e) {
            system.debug('Error : '+e);
        }
    }
    
    
    /* Get list of elements of type workflow */
    public  List<String> getQueryElementList(list<switchStructure> listOfElements)
    {
        List<String> querylist = new List<String>();
        for(switchStructure element:listOfElements)
            querylist.add(element.FullName);
        return querylist;
    }
    
    
    
    
    /* Set isActive true for all elements of workflow rule type */
    public  List<switchStructure> setIsActiveElement(list<switchStructure> listOfElements)
    {
        MetadataService.MetadataPort service = MetadataApi.createService();
        list<string> querylist = getQueryElementList(listOfElements);
        
        if(listOfElements[0].type==Workflow)
        {
            workflowResults =(list<MetadataService.Workflowrule>) service.readMetadata(Workflow,querylist).getRecords();
            system.debug('workflowResults'+workflowResults);
            if(workflowResults.size()>0 && !workflowResults.isEmpty()){
                for(integer i=0;i<workflowResults.size();i++)
                {
                    for(switchStructure switchElement:listOfElements)
                    {
                        if(switchElement.FullName.containsIgnoreCase(workflowResults[i].fullName))
                        {
                            switchElement.isActive = workflowResults[i].active;
                        }
                    }
                }
            }
        }
        else if(listOfElements[0].type==Validation)
        {
            validationResults =(list<MetadataService.ValidationRule>) service.readMetadata(Validation,querylist).getRecords();
            if(validationResults.size()>0 && !validationResults.isEmpty()){
                for(integer i=0;i<validationResults.size();i++)
                {
                    for(switchStructure switchElement:listOfElements)
                    {
                        if(switchElement.FullName.containsIgnoreCase(validationResults[i].fullName))
                        {
                            switchElement.isActive = validationResults[i].active;
                        }
                    }
                }
            }
        }
        Return listOfElements;
    }
    
    
    /* */
    public  void setIsActiveforAll(){
        //Map<string,list<switchStructure>> mapOfElements = getElementData();
        getElementData();
        
        list<switchStructure> workflowList = mapOfElements.get(Workflow);
        list<switchStructure> validationList = mapOfElements.get(Validation);
        validationList = setIsActiveElement(validationList);
        workflowList = setIsActiveElement(workflowList);
        mapOfElements.put(Workflow,workflowList);
        mapOfElements.put(Validation,validationList);
        List<switchStructure> tempList = new List<switchStructure>();
        
        tempList = new List<switchStructure>();
        workflowPrintList = new List<switchStructure>();
        validationPrintList = new List<switchStructure>();
        //triggerPrintList = new List<switchStructure>();
        
        workflowPrintList.addAll(mapOfElements.get(Workflow));
        validationPrintList.addAll(mapOfElements.get(Validation));
        //triggerPrintList.addAll(mapOfElements.get(Triggers));
        tempList.addAll(workflowPrintList);
        tempList.addAll(validationPrintList);
        //tempList.addAll(triggerPrintList);
        if (selectedType=='Metadata')
        {    
            //?PrintList = new List<switchStructure>();
            //PrintList.addAll(tempList);
            isRenderMetadataTable= true;
            isRenderObjectTable=false;
            selectedType=NULL;
        }
        else if(selectedType=='None')
        {
            selectedType=NULL;
        }
        else
        {
            PrintList = new List<switchStructure>();
            for(switchStructure pList:tempList) 
            {
                if(pList.ObjectName==selectedObject)
                {
                    PrintList.add(pList);  
                }
            }    
            isRenderObjectTable=true;
            isRenderMetadataTable= false;
            selectedType=NULL;
            selectedObject = NULL;
        }
    }	
    Public  void updateMetadata()
    {
        system.debug('workflowResults'+workflowResults);
        MetadataService.MetadataPort service = MetadataApi.createService();
        //list<MetadataService.ApexTrigger> updateTriggerList = new list<MetadataService.ApexTrigger>();
        if(isRenderObjectTable)
        {
            list<switchStructure> Listwork=new list<switchStructure>();
            list<switchStructure> Listval=new list<switchStructure>();
            for(switchStructure sObj:PrintList)
            {
                if(sObj.type==Workflow)    
                    Listwork.add(sObj);
                else if(sObj.type==Validation)	
                    Listval.add(sObj);
            }
            updateIsActiveInList(Listwork,Listval);
        }
        else if (isRenderMetadataTable)
        {
            list<switchStructure> Listwork=new list<switchStructure>();
            Listwork.addAll(workflowPrintList);
            list<switchStructure> Listval=new list<switchStructure>();
            Listval.addAll(validationPrintList);
            updateIsActiveInList(Listwork,Listval);
        }
        
        MetadataDefaultServiceExamples.handleSaveResults(service.updateMetadata( validationResults)[0]);
        MetadataDefaultServiceExamples.handleSaveResults(service.updateMetadata( workflowResults)[0]);
        //MetadataDefaultServiceExamples.handleSaveResults(service.updateMetadata( updateTriggerList)[0]);
    }
    public void updateIsActiveInList(List<switchStructure> Listwork,List<switchStructure> Listval)
    {
        for(MetadataService.Workflowrule wrObj:workflowResults)
        {
            for(switchStructure sobj:Listwork)
            {
                if(wrObj.fullname.containsIgnoreCase(sobj.FullName))
                    wrObj.active = sObj.isActive;
            }
        }
        for(MetadataService.ValidationRule valObj:validationResults)
        {
            for(switchStructure sObj:Listval)
            {
                if(valObj.fullname.containsIgnoreCase(sobj.FullName))
                    valObj.active = sObj.isActive;
            }
        }
    }
    public static void forNowTestTriggerUpdate()
    {
        //MetadataService.MetadataPort service = new MetadataService.MetadataPort();

//service.SessionHeader = new MetadataService.SessionHeader_element();
//service.SessionHeader.sessionId = UserInfo.getSessionId();
 //MetadataService.MetadataPort service = MetadataApi.createService();     
        
//List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();  

//MetadataService.ListMetadataQuery queryDocumentFolder = new MetadataService.ListMetadataQuery();
//queryDocumentFolder.type_x = 'DocumentFolder';
//queries.add(queryDocumentFolder);       
//MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 30);
//List<String> folderNames = new List<String>();
//for(MetadataService.FileProperties fileProperty : fileProperties)
//	folderNames.add(fileProperty.fileName.replace('documents/', ''));
//system.debug('folderNames'+folderNames);
//List<MetadataService.DocumentFolder> folder= (List<MetadataService.DocumentFolder>) service.readMetadata('DocumentFolder', folderNames).getRecords();
  //             system.debug('folder'+folder);
        /*list<MetadataService.ApexTrigger> updateTriggerList = new list<MetadataService.ApexTrigger>();
        MetadataService.ApexTrigger trig = new MetadataService.ApexTrigger();
        trig.fullName='TestTrigger';
        trig.type='ApexTrigger';
        trig.content='trigger TestTrigger on Account (before insert) { }	';
        //trig.apiVersion = 36.0;
       // trig.TableEnumOrId
        trig.Status='Active';
        updateTriggerList.add(trig);
        //	MetadataDefaultServiceExamples.handleSaveResults(service.updateMetadata( updateTriggerList)[0]);*/
     
        
        // Create the DeployOptions object.
//MetadataService.DeployOptions deployOptions = new MetadataService.DeployOptions();
// Set the appropriate test level.
//deployOptions.setTestLevel(testLevel.RunLocalTests);
// Call deploy() by passing the deployment options object as an argument.
//MetadataService.AsyncResult asyncResult = metadatabinding.deploy(zipBytes,deployOptions);
		//MetadataService.RetrieveRequest retReq= new MetadataService.RetrieveRequest();
        //string abc = 'TestTrigger';
        //retReq.specificFiles=new string[]{'TestTrigger'};
        //retReq.apiVersion = 36.0;
        //retReq.singlePackage = true;
        //retReq.specificFiles.add(abc);
        //MetadataService.AsyncResult async = service.retrieve(retReq);
		//system.debug('async'+async);
        //system.debug('async.statusCode : '+async.statusCode);
        //system.debug('async.state : '+async.state);
        //system.debug('async.message : '+async.message);
        //system.debug('async.id : '+async.id);
        //MetadataService.RetrieveResult pqr = service.checkRetrieveStatus(async.id,true);
        //system.debug('RetrieveResult'+pqr);
		//system.debug('pqr.zipFile :	'+pqr.zipFile);       
        //system.debug('pqr.errorMessage :	'+pqr.errorMessage);
        //system.debug('pqr.errorMessage :	'+pqr.errorMessage);
        
    }
}