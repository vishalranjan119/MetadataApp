public class ValidateData {
    
    public static Boolean isValidationComplete1=TRUE;
    public static Boolean isValidationComplete2=TRUE;
    public static Boolean isValidationComplete3=TRUE;
    public static Boolean isValidationComplete4=TRUE;
    public static Boolean isValidationComplete5=TRUE;
    public static Boolean isValidationComplete6=TRUE;
    public static Boolean isValidationComplete7=TRUE;
    public static Boolean isValidationComplete8=TRUE;
    
    public static Boolean validateDataBeforeSubmit(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList){
            ds.errorMap = new Map<integer,boolean>();
            for(Integer i=1; i<=25;i++)
                ds.errorMap.put(i,false);
        }
        validateLength(dsList);
        validatePicklist(dsList);
        validateLengthAndDecimal(dsList);
        validateVisibleLines(dsList);
        validateDefaultValue(dsList);
        validateLookUp(dsList);
        validateHelpTextAndDescription(dsList);
        validateTrackFieldHistory(dsList);
        if(isValidationComplete1==FALSE || isValidationComplete2==FALSE || isValidationComplete3==FALSE || isValidationComplete4==FALSE || isValidationComplete5==FALSE || isValidationComplete6==FALSE || isValidationComplete7==FALSE || isValidationComplete8==FALSE || validateFieldLabelnName(dsList))
            return false;
        return true;
    }
    
    private static void validateLength(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.dataTypeContainsLengthField.contains(ds.fieldType) && !ds.dataTypeContainsLengthField_NUMBER.contains(ds.fieldType))
            {
                
                if(ds.length=='' || ds.length==null)
                {
                    isValidationComplete1=FALSE;
                    ds.errorMap.put(8,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter length-> '+ds.fieldLabel)); 
                }
                else if(!ds.length.isNumeric())
                {
                    isValidationComplete1=FALSE;
                    ds.errorMap.put(8,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter valid value for length-> '+ds.fieldLabel)); 
                }
                
                
                else
                {
                    if(ds.fieldType=='Text')    
                    {System.debug('---Text'+ds.fieldType);
                     if(integer.valueOf(ds.length)>ApexLimitConstants.maxTextLength)
                     {
                         System.debug('abc');
                         ds.errorMap.put(8,true);
                         isValidationComplete1=FALSE;
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be less than or equal to '+ApexLimitConstants.maxTextLength+'->'+ds.fieldLabel)); 
                     }
                     else if(integer.valueOf(ds.length)<=ApexLimitConstants.minLength)
                     {
                         isValidationComplete1=FALSE;
                         ds.errorMap.put(8,true);
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be greater than 0-> '+ds.fieldLabel)); 
                     }
                    }
                    else if(ds.fieldType=='LongTextArea' || ds.fieldType=='Html')
                    {
                        if(integer.valueOf(ds.length)<=ApexLimitConstants.minLength)
                        {
                            isValidationComplete1=FALSE;
                            ds.errorMap.put(8,true);
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be greater than 0-> '+ds.fieldLabel)); 
                        }
                        else if(ds.fieldType=='LongTextArea')
                        {
                            if(integer.valueOf(ds.length)>ApexLimitConstants.maxLongTextAreaLength)
                            {
                                isValidationComplete1=FALSE;
                                ds.errorMap.put(8,true);
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be less than or equal to '+ApexLimitConstants.maxLongTextAreaLength+'->'+ds.fieldLabel)); 
                            }
                        }
                        else if(ds.fieldType=='Html')
                        {
                            if(integer.valueOf(ds.length)>ApexLimitConstants.maxRichTextAreaLength)
                            {
                                isValidationComplete1=FALSE;
                                ds.errorMap.put(8,true);
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be less than or equal to '+ApexLimitConstants.maxRichTextAreaLength+'->'+ds.fieldLabel)); 
                            }
                        }
                    }
                }
            }        
        }
    }
    
    private static void validatePicklist(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.fieldType=='Picklist')
            {
                if(ds.picklistValue=='' || ds.picklistValue==null)
                {
                    isValidationComplete2=FALSE;
                    ds.errorMap.put(11,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter picklist values-> '+ds.fieldLabel));
                }
                else
                {
                    if(ds.picklistValue.length()>15000)
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Character length exceeded for picklist values. Maximum length is 15000-> '+ds.fieldLabel));
                        ds.errorMap.put(11,true);
                    }
                }
            }
        }
    }
    
    
    private static void validateLengthAndDecimal(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.dataTypeContainsLengthField_NUMBER.contains(ds.fieldType))
            {
                if(ds.length=='' || ds.length==null)
                {
                    isValidationComplete5=FALSE;
                    ds.errorMap.put(8,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter length-> '+ds.fieldLabel)); 
                }
                else if(!ds.length.isNumeric())
                {
                    isValidationComplete5=FALSE;
                    ds.errorMap.put(8,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter valid value for length-> '+ds.fieldLabel)); 
                }
                if(ds.decimalPlace=='' || ds.decimalPlace==null)
                {
                    isValidationComplete5=FALSE;
                    ds.errorMap.put(9,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter decimal value-> '+ds.fieldLabel)); 
                }
                else if(!ds.decimalPlace.isNumeric())
                {
                    isValidationComplete5=FALSE;
                    ds.errorMap.put(9,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter valid value for decimal place-> '+ds.fieldLabel)); 
                }
                else if(((ds.length!='' || ds.length!=null) && ds.length.isNumeric())&&(ds.decimalPlace!='' || ds.decimalPlace!=null) && ds.decimalPlace.isNumeric())
                {
                    if((integer.valueof(ds.length)>ApexLimitConstants.maxNumberLength || integer.valueof(ds.decimalPlace)>ApexLimitConstants.maxNumberLength))
                    {
                        isValidationComplete5=FALSE;
                        ds.errorMap.put(8,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be less than or equal to 18-> '+ds.fieldLabel));
                    }
                    else if((integer.valueof(ds.length)<=ApexLimitConstants.minLength || integer.valueof(ds.decimalPlace)<ApexLimitConstants.minLength))
                    {
                        isValidationComplete5=FALSE;
                        ds.errorMap.put(8,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length must be an integer greater than 0-> '+ds.fieldLabel));
                    }
                    if(((integer.valueof(ds.length) + integer.valueOf(ds.decimalPlace))>ApexLimitConstants.maxNumberLength))
                    {
                        isValidationComplete5=FALSE;
                        ds.errorMap.put(8,true);
                        ds.errorMap.put(9,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The sum of the length and decimal places must be an integer less than or equal to 18-> '+ds.fieldLabel));
                    }
                }
            }
        }
    }
    
    
    private static void validateDefaultValue(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.fieldDefaultValue!=NULL && ds.fieldDefaultValue!='')
            {
                if(ds.required==True || ds.externalId==True || ds.unique==True)
                {
                    isValidationComplete6=FALSE;
                    ds.errorMap.put(13,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Default value cannot be entered for REQUIRED, UNIQUE and EXTERNAL ID fields '+ds.fieldLabel));
                }
                if(ds.fieldDefaultValue.length()>3900)
                {
                    isValidationComplete6=FALSE;
                    ds.errorMap.put(13,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length exceeded. Default value maximum length is 3,900 characters '+ds.fieldLabel));
                }
                
                else if(ds.dataTypeContainsDefaultField.contains(ds.fieldType))
                {
                    if(ds.fieldType=='Checkbox' && (!ds.fieldDefaultValue.equalsIgnoreCase('TRUE') && !ds.fieldDefaultValue.equalsIgnoreCase('False')))
                    {
                        isValidationComplete6=FALSE;
                        ds.errorMap.put(13,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Default value must be either TRUE or FALSE '+ds.fieldLabel));
                    }
                    
                    if(ds.dataTypeContainsLengthField_NUMBER.contains(ds.fieldType) && ((ds.fieldDefaultValue.countMatches('.')!=0 && ds.fieldDefaultValue.countMatches('.')!=1) || !ds.fieldDefaultValue.replace('.','').trim().isNumeric()))
                    {
                        isValidationComplete6=FALSE;
                        ds.errorMap.put(13,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter valid default value (number) '+ds.fieldLabel));
                    }
                    
                    if(ds.fieldType=='URL' && !ds.fieldDefaultValue.isAlpha())
                    {
                        isValidationComplete6=FALSE;
                        ds.errorMap.put(13,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter text only '+ds.fieldLabel));
                    }
                    if(ds.fieldType=='Email')
                    {
                        String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
                        Pattern MyPattern = Pattern.compile(emailRegex);
                        Matcher MyMatcher = MyPattern.matcher(ds.fieldDefaultValue);
                        if(!MyMatcher.matches())
                        {
                            isValidationComplete6=FALSE;
                            ds.errorMap.put(13,true);
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter valid Email '+ds.fieldLabel));
                        }
                    }
                }
            }
        }
    }
    
    
    private static void validateHelpTextAndDescription(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            System.debug('Helptext@@'+ds.helpText.length());
            if((ds.helpText!=NULL || ds.helpText!='') && ds.helpText.length()>255)
            {
                isValidationComplete7=FALSE;
                ds.errorMap.put(22,true);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length of charcters in helptext must be less than 255 characters-> '+ds.fieldLabel));
            }
            if((ds.Description!=NULL || ds.Description!='') && ds.Description.length()>1000)
            {
                isValidationComplete7=FALSE;
                ds.errorMap.put(22,true);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Length of characters in description must be less than 1000 characters-> '+ds.fieldLabel));
            }
        }
    }
    
    private static void validateTrackFieldHistory(List<DataStructure> dsList)
    {
        Integer trackFieldHistoryCount=0;
        Set<String> objectNames=new Set<String>();
        Map<String, Integer> mapOfObjectAndCount = new Map<String, Integer>();
        
        // Set<String> objectSet = new Set<String>();
        
        for(DataStructure ds: dsList)
        {
            //objectSet.add(ds.objectName);
            
            if(ds.trackFeedHistory==TRUE)
            {
                if(mapOfObjectAndCount.containsKey(ds.objectName))
                {
                    trackFieldHistoryCount=mapOfObjectAndCount.get(ds.objectName);
                    trackFieldHistoryCount++;
                    mapOfObjectAndCount.put(ds.objectName, trackFieldHistoryCount);
                    
                    if(trackFieldHistoryCount>20)
                    {
                        objectNames.add(ds.objectName);
                        isValidationComplete8=FALSE;
                    }
                }
                else
                {
                    trackFieldHistoryCount=1;
                    mapOfObjectAndCount.put(ds.objectName, trackFieldHistoryCount);
                }
            }
            if(trackFieldHistoryCount>20)
            {
                for(String s: objectNames)
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Track field history can be applied to maximum 20 fields-> '+s));
                }
            }
        }   
        String obj = 'Account';
        
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(obj); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
        System.debug('sobjectname@@@'+obj);
        System.debug('gd@@@'+gd);
        System.debug('fieldsMap@@@'+ fieldsMap);
        System.debug('1234567890');
    }
    
    private static void validateVisibleLines(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.dataTypeContainsVisibleLinesField.contains(ds.fieldType))
            {
                if((ds.visibleLines=='' || ds.visibleLines==null))
                {
                    isValidationComplete3=FALSE;
                    ds.errorMap.put(10,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter the number of visible lines-> '+ds.fieldLabel)); 
                }
                
                else if(!ds.visibleLines.isNumeric())
                {
                    isValidationComplete3=FALSE;
                    ds.errorMap.put(10,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Enter numeric value for visible lines-> '+ds.fieldLabel)); 
                }
                else if(ds.fieldType=='MultiselectPicklist')
                {
                    if(integer.valueof(ds.visibleLines)>ApexLimitConstants.maxVisibleLinesMultiSelectPicklist)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be less than or equal to '+ApexLimitConstants.maxVisibleLinesMultiSelectPicklist +'->'+ds.fieldLabel));
                    }
                    else if(integer.valueof(ds.visibleLines)<ApexLimitConstants.minVisibleLinesMultiSelectPicklist)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be greater than or equal to '+ApexLimitConstants.minVisibleLinesMultiSelectPicklist +'->'+ds.fieldLabel));
                    }
                }
                else if(ds.fieldType=='Html')
                {
                    if(integer.valueof(ds.visibleLines)>ApexLimitConstants.maxVisibleLinesRichTextArea)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be less than or equal to '+ApexLimitConstants.maxVisibleLinesRichTextArea +'->'+ds.fieldLabel));
                    }
                    else if(integer.valueof(ds.visibleLines)<ApexLimitConstants.minVisibleLinesRichTextArea)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be greater than or equal to '+ApexLimitConstants.minVisibleLinesRichTextArea +'->'+ds.fieldLabel));
                    }
                }
                else if(ds.fieldType=='LongTextArea')
                {
                    if(integer.valueof(ds.visibleLines)>ApexLimitConstants.maxVisibleLinesLongTextArea)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be less than or equal to '+ApexLimitConstants.maxVisibleLinesLongTextArea +'->'+ds.fieldLabel));
                    }
                    else if(integer.valueof(ds.visibleLines)<ApexLimitConstants.minVisibleLinesLongTextArea)
                    {
                        isValidationComplete3=FALSE;
                        ds.errorMap.put(10,true);
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Number of visible lines must be greater than or equal to '+ApexLimitConstants.minVisibleLinesLongTextArea +'->'+ds.fieldLabel));
                    }
                }
            }
        }
    }
    
    private static void validateLookUp(List<DataStructure> dsList)
    {
        for(DataStructure ds: dsList)
        {
            if(ds.fieldType=='Lookup')
            {
                if(ds.relatedToObject=='' || ds.relatedToObject==null)
                {
                    isValidationComplete4=FALSE;
                    ds.errorMap.put(18,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the required fields for lookup type->'+ds.fieldLabel));
                }
                else if(ds.childRelationshipName=='' || ds.childRelationshipName==null)
                {
                    isValidationComplete4=FALSE;
                    ds.errorMap.put(19,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the required fields for lookup type->'+ds.fieldLabel));
                }
                else if(ds.relatedListLabel=='' || ds.relatedListLabel==null)
                {
                    isValidationComplete4=FALSE;
                    ds.errorMap.put(20,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please fill all the required fields for lookup type->'+ds.fieldLabel));
                }	   
                String str=ds.childRelationshipName.substring(0,1);
                if(str.isNumeric())
                {
                    isValidationComplete4=FALSE;
                    ds.errorMap.put(19,true);
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Name must not start with number->'+ds.fieldLabel));
                }
            }
        }        
    }
    
    public static  Boolean validateConversionOfFieldType(DataStructure ds)
    {
        if(ds.fieldType=='Lookup' && ds.changedDataType!='REFERENCE')
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Lookup field type can only changed to Master Details'));
            ds.isUpdatable=false;
            ds.changedDataType=ds.fieldType;
        }
        
        else if(ds.fieldType!='Lookup' && ds.changedDataType =='REFERENCE' && ds.fieldType != ds.changedDataType )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Can not change field type from '+ds.fieldType+' to '+ds.changedDataType));
            ds.isUpdatable=false;
            ds.changedDataType=ds.fieldType;
        }
        
        if(ds.fieldType=='REFERENCE' && ds.changedDataType!='Lookup' )
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Master Details field type can only changed to Lookup'));
            ds.isUpdatable=false;
            ds.changedDataType=ds.fieldType;
        }
        
        else if( ds.fieldType != ds.changedDataType && ds.fieldType!='REFERENCE' && ds.changedDataType =='Lookup')
        {
            System.debug(''+ds.fieldType+'****'+ds.changedDataType);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Can not change field type from '+ds.fieldType+' to '+ds.changedDataType));
            ds.isUpdatable=false;
            ds.changedDataType=ds.fieldType;                    
        }
        
        if(ds.changedDataType=='Location')
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Can not change to Field Type GeoLocation'));
            ds.isUpdatable=false;
            ds.changedDataType=ds.fieldType;
        }
        return true;
    }
    public static Boolean validateFieldLabelnName(List<DataStructure> dsList){
        Boolean temp = true;
        if(dsList.size() == 0 || dsList == null || dsList.isEmpty() ){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Oops, Please add atleast one field to go to next step!'));
            return false;
        }
        else{
            Integer i=1;           
            for(DataStructure ds:dsList){
                if(ds.fieldLabel == '' || ds.fieldLabel ==null || ds.fieldName == ''|| ds.fieldName == null || (ds.length!=null && ds.length=='')  ){
                    temp = false;
                    String tempStr = '';
                    if(i==1){
                        tempStr ='1st';
                    }else if(i==2){
                        tempStr ='2nd';
                    }else if(i==3){
                        tempStr ='3rd';
                    }else{
                        tempStr =i+'th'; 
                    }
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Oops,You have misssed something important in '+tempStr+' row'));
                }
                i++;
            }            
        }
        return temp;
    }
    public static Boolean checkForEmptyList(List<DataStructure> dsList){
        
        return true;        
    }
    public static Boolean validateCustomLabel(List<CustomLabelDS> dsList)
    {
        Integer i=1;
        boolean b=true;
        for(CustomLabelDS customLabel: dsList)
        {
           
            
            if(!Pattern.matches('^(?!.*__.*)[a-zA-Z][a-zA-Z0-9_]*[a-zA-Z0-9]$',customLabel.labelName))
            {
                b=false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'The Name field can only contain underscores and alphanumeric characters. It must be unique, begin with a letter, not include spaces, not end with an underscore, and not contain two consecutive underscores. Check '+i+'th row'));
            }
            if(customLabel.shortDesc.length()>80)
            {
                b=false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Maximum Length for Short Description is 80 Characters. Check '+i+'th row'));
            }
            if(customLabel.shortDesc=='')
            {
                b=false;
                System.debug(customLabel.shortDesc);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You must enter a value. Check '+i+'th row'));
            }
            if(customLabel.categories.length()>1000)
            {
                b=false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Maximum Length for Categories is 1000 Characters. Check '+i+'th row'));
            }
            if(customLabel.labelValue.length()>1000)
            {
                b=false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Maximum Length for Categories is 1000 Characters. Check '+i+'th row'));
            }
            if(customLabel.labelValue=='')
            {
                b=false;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error!!You must enter a value. Check '+i+'th row'));
            }
            i++;
            
			//System.debug(b); 
        }
        return b;
    }
}