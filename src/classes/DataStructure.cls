public class DataStructure {
    
    public set<String> dataTypeContainsLengthField = new set<string>{'Text','LongTextArea','Html','Number','Percent','Currency'};  
    public set<String> dataTypeContainsDecimalPlaceField = new set<String>{'Number','Percent','Currency','Location'};
    public set<String> dataTypeContainsVisibleLinesField = new set<String>{'PickList','MultiselectPicklist','LongTextArea','Html'};  
    public set<String> dataTypeContainsRequiredField = new set<String>{'Lookup','Location','Text','Currency','Date','DateTime','Email','Number','Percent','Phone','TextArea','Url'};
    public set<String> dataTypeContainsDefaultField = new set<String>{'Checkbox','Text','Currency','Date','DateTime','Email','Number','Percent','Phone','TextArea','LongTextArea','Url'};    
    public set<String> dataTypeContainsUniqueField = new set<String>{'Email','Number','Text'};
    public set<String> dataTypeContainsExternalIDField = new set<String>{'Email','Number','Text'};
    public set<String> dataTypeContainsPrecisionField= new set<String>{'Number','Percent','Currency'}; 
    public set<String> dataTypeContainsLengthField_NUMBER = new set<string>{'Number','Percent','Currency'};  
    public set<String> dataTypeNotSupportingCountFunction = new set<string>{'MultiselectPicklist','Location','LongTextArea','Checkbox'};
        
    public String objectName{get;set;}
    public String fieldName{get;set;}
    public String fieldType{get;set;}
    public String fieldLabel{get;set;}
    public String length{get;set;}
    public String decimalPlace{get;set;}
    public String visibleLines{get;set;}
    public List<String> picklistValues{get;set;}
    public Boolean picklistSorted{get;set;}
    public String picklistSortedCheck{get;set;}
    public String fieldDefaultValue{get;set;}
    public Boolean required{get;set;}
    public String requiredCheck{get;set;}
    public Boolean trackFeedHistory{get;set;}
    public Boolean externalId{get;set;}
    public String externalIdCheck{get;set;}
    public Boolean unique{get;set;}
    public String uniqueCheck{get;set;}
    public String Description{get;set;}
    public String helpText{get;set;}
    public String picklistValue{get;set;}
    
    public String relatedToObject{get;set;}
    public String childRelationshipName{get;set;}
    public String relatedListLabel{get;set;}
    
    public String errorMsg{get;set;}
    public String result{get;set;}
    public String resultCheck{get;set;}
    public String lookupFieldCheck{get;set;}
    
    public Boolean iSEditable{get;set;}
    public Boolean applyFlS{get;set;}

    public SelectOption[] selectedOptionsForReadOnly { get; set; }
    public SelectOption[] allOptionsForReadOnly { get; set; }
    public SelectOption[] selectedOptionsForVisibleOnly { get; set; }
    public SelectOption[] allOptionsForVisibleOnly { get; set; }
    
    public SelectOption[] selectedOptionsForLayoutAssignment { get; set; }
    public SelectOption[] allOptionsForLayoutAssignment { get; set; }
    
    public Boolean isDeletable{get;set;}
    public String changedDataType{get;set;}
    public Boolean isUpdatable{get;set;}
    
    public Map<integer,boolean> errorMap {get;set;}
    
    public DataStructure()
    {
        errorMap = new Map<integer,boolean>();
        for(Integer i=1; i<=25;i++)
            errorMap.put(i,false);
    }
    
    public String countPopulatedFields{get;set;}
    public Integer count1{get;set;}
    
    // addded by Sahil Wadhwa for update module to display values in picklist according to its type
    public SelectOption[] dataTypeChangePickListValues { get; set; }
   
}