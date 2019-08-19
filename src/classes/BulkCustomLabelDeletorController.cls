public class BulkCustomLabelDeletorController {
    
    public List<CustomLabelDS> getData{get;set;}
    private Boolean isCancelCalled = false;
    public  List<CustomLabelDS> dsList2{get;set;}
    private  List<CustomLabelDS> dsListToDelete=new LIST<CustomLabelDS>();
    public Boolean clearPreviousRecords{get;set;}
    private Boolean isgetdsListCalled=false;
    public Boolean isDeleted{get;set;}
    public Boolean isObjectSelected{get;set;}
    public string statu{get;set;}
    public Boolean data{get;set;}
    
    public BulkCustomLabelDeletorController()
    {
        
		getData=new List<CustomLabelDS>();
        MetaDataApi obj=new MetaDataApi();
        try
        {
        	getData=obj.fetchAllLabels();
            
        }
        catch(Exception e){}
        if(getData.isEmpty())
                data=false;
            else
                data=true;
        System.debug(data+'mohsin');
        isObjectSelected=true;
        clearPreviousRecords=true;
        statu='none';
    }
    
    public PageReference display()
    {
        Integer count=0;
        for(CustomLabelDS ds:getData)
        {
            if(ds.isDeletable)
            {
                count++;
               // System.debug(count);
        	}
        }
        
        if(count>0)
        {
            statu='block';
            System.debug(count);
        }
        else
        {
            statu='none';
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select some fields to delete!!!'));
            System.debug('in');
        }
        return null;
    }
    
    public PageReference goToSecondPage()
    {
        PageReference secondPage = new PageReference('/apex/BulkCustomLabelDeletorWarningScreen');
      //  PageReference pageRef = ApexPages.currentPage();
        List<String> fieldsToDelete=new LIST<String>();
        
        dsListToDelete.clear();
        for(CustomLabelDS ds:getData)
        {
            if(ds.isDeletable)
            {
                fieldsToDelete.add(ds.labelName);
                dsListToDelete.add(ds);
            }
        }
       
        if(dsListToDelete.isEmpty() || dsListToDelete.size()==0 || dsListToDelete==NULL)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select some fields to delete!!!'));
         	return null;
        }
        else
        {
            dsList2=new LIST<CustomLabelDS>(getData);
            
            if(clearPreviousRecords)
            {
                getData.clear();
            }
            
            if(!dsListToDelete.isEmpty() && dsListToDelete.size()>0)
                isgetdsListCalled=true;
                        
            return secondPage;
        }
        
    }
    public  PageReference deleteSelectedField()
    {   
		for(CustomLabelDS obj:getData)
        {
            if(obj.isDeletable==true)
                dsListToDelete.add(obj);
        }
        List<MetadataService.DeleteResult> deleteResultList=MetadataApi.deleteCustomLabel(dsListToDelete);
        System.debug('deleteResultList'+deleteResultList);
        handleDeleteResult(deleteResultList);
        return null;
    }
    public PageReference goToFirstPage()
    {
        isDeleted = false;
        getData.clear();
        //dsList2.clear();
        dsListToDelete.clear();
        PageReference firstPage = new PageReference('/apex/BulkCustomLabelDeletor');
		firstPage.setRedirect(true);
        return firstPage;
    }
    public void handleDeleteResult(List<MetadataService.DeleteResult> deleteResultList)
    {
        System.debug('****************************');
        isDeleted = true;
        //if(!deleteResultList.isEmpty() && deleteResultList.size()>0)
        {
            Integer delResultCount=0;
            for(CustomLabelDS ds:dsListToDelete){
                System.debug('dsFieldName'+ds);
                System.debug('deleteResult'+deleteResultList[delResultCount]);
                if(delResultCount<deleteResultList.size()){   
                    if(deleteResultList[delResultCount]==null || deleteResultList[delResultCount].success){
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
            }
        }
    }
    

}