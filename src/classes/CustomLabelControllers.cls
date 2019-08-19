public class CustomLabelControllers
{
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    public Boolean displayModal{get;set;}
    public List<CustomLabelDS> getData{get;set;}
    public List<String> tableHeaders{get;set;}
    public Integer count=0;
    public Boolean show{get;set;}
    public Boolean created{get;set;}
    public String myString {get;set;}
    public Boolean status {get;set;}
    public Boolean ChineseSimplified{get;set;}
    public Boolean ChineseTraditional{get;set;}
    public Boolean Danish{get;set;}
    public Boolean Dutch{get;set;}
    public Boolean English{get;set;}
    public Boolean Finnish{get;set;}
    public Boolean French{get;set;}
    public Boolean German{get;set;}
    public Boolean Italian{get;set;}
    public Boolean Japanese{get;set;}
    public Boolean Korean{get;set;}
    public Boolean Norwegian{get;set;}
    public Boolean Portuguese{get;set;}
    public Boolean Russian{get;set;}
    public Boolean Spanish{get;set;}
    public Boolean SpanishMexico{get;set;}
    public Boolean Swedish{get;set;}
    public Boolean Thai{get;set;}
    public String message {get;set;}
    String successString;
    String errorString;
    String fileRow;
    public List<CustomLabelDS> customLabels= new List<CustomLabelDS>();
    public Set<String> fieldsPresent{get;set;}
    List<String> fieldsPresentList;
    public transient Component.Apex.PageBlockTable table{get;set;}
    public List<String> translationsName{get;set;}
    public CustomLabelControllers()
    { 
        ChineseSimplified=false;
        ChineseTraditional=false;
        Danish=false;
        Dutch=false;
        English=false;
        Finnish=false;
        French=false;
        German=false;
        Italian=false;
        Japanese=false;
        Korean=false;
        Norwegian=false;
        Portuguese=false;
        Russian=false;
        Spanish=false;
        SpanishMexico=false;
        Swedish=false;
        Thai=false;
		successString='';
        errorString='';
        fileRow='';
        myString= ' ';
        status= true;
        fieldsPresent= new Set<String>();
        
        fieldsPresentList = new list<String>();
        created = false;
        getData=new List<CustomLabelDS>();
        tableHeaders=new List<String>{'Short Description','Name','Protected Component','Categories','Value'};
            Set<String> translations=MetadataApi.fetchAllTranslations();
        	translationsName= new List<String>();
        	for(String language: translations)
            {
                if(language=='zh_CN')
                {
                    translationsName.add('Chinese (Simplified)');
                    ChineseSimplified=true;
                    //System.debug(ChineseSimplified+'afafamohsin');
                }
                if(language=='zh_TW')
                {
                    translationsName.add('Chinese (Traditional)');
                    ChineseTraditional=true;
                }
                if(language=='da')
                {
                    translationsName.add('Danish');
                    Danish=true;
                }
                if(language=='nl_NL')
                {
                    translationsName.add('Dutch');
                    Dutch=true;
                }
                if(language=='en_US')
                {
                    translationsName.add('English');
                    English=true;
                }
                if(language=='fi')
                {
                    translationsName.add('Finnish');
                    Finnish=true;
                }
                if(language=='fr')
                {
                    translationsName.add('French');
                    French=true;
                }
                if(language=='de')
                {
                    translationsName.add('German');
                    German=true;
                }
                if(language=='it')
                {
                    translationsName.add('Italian');
                    Italian=true;
                }
                if(language=='ja')
                {
                    translationsName.add('Japanese');
                    Japanese=true;
                }
                if(language=='ko')
                {
                    translationsName.add('Korean');
                    Korean=true;
                }
                if(language=='no')
                {
                    translationsName.add('Norwegian');
                    Norwegian=true;
                }
                if(language=='pt_BR')
                {
                    translationsName.add('Portuguese (Brazil)');
                    Portuguese=true;
                }
                if(language=='ru')
                {
                    translationsName.add('Russian');
                    Russian=true;
                }
                if(language=='es')
                {
                    translationsName.add('Spanish');
                    Spanish=true;
                }
                if(language=='es_MX')
                {
                    translationsName.add('Spanish (Mexico)');
                    SpanishMexico=true;
                }
                if(language=='sv')
                {
                    translationsName.add('Swedish');
                    Swedish=true;
                }
                if(language=='th')
                {
                    translationsName.add('Thai');
                    Thai=true;
                }
                
                
            }
        	translationsName.sort();
        	//tableHeaders.addAll(translationsName);
             //System.debug(myString);
    }
    public void hide()
    {
        created = false;
        show=false;
    }
    public void validate()
    {
        show=ValidateData.validateCustomLabel(getData);
        
    }
    public Pagereference ReadFile()
    {
        
        try
        {
            previewData();
            if(getData.isEmpty())
            {
             	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Upload a File')); 
            	return null;  
            }
            else
            {
                PageReference editPage = goToEditPage();
                System.debug('asfafa');
                return editPage;
            }
        }
        catch(Exception e)
        {
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please Upload a File')); 
            return null;
        }
    }
    
    public Pagereference onSkip(){
        getData.clear();
        PageReference editPage = goToEditPage();
        editPage.setRedirect(true);
        //profileList = helper.createStructureForFLS();
        return editPage;
    }
    
    public PageReference goToEditPage()
    {
        displayModal = false;
        PageReference editPage = new PageReference('/apex/CustomLabelCreateNew');
        return editPage;
    }
    public PageReference goToMainPage(){        
        PageReference editPage = new PageReference('/apex/CustomLabelCreatePage');
        editPage.setRedirect(true);
        return editPage;
    }
    
    public void create()
    {
        created = true;
        List<MetadataService.SaveResult> results = MetadataApi.createCustomLabel(getData);
        Integer count=0;
        for(MetadataService.SaveResult saveResult:results)
        {
            if(saveResult==null || saveResult.success)
            {
                getData[count].errorMsg=null;
                
                getData[count].result='Success';
                
            }
            if(saveResult.errors!=null)
            {
                getData[count].result='error';
                List<String> messages = new List<String>();               
                for(MetadataService.Error error : saveResult.errors)
                    messages.add(error.message);
                if(messages.size()>0)
                {
                    getData[count].errorMsg=String.join(messages, ' '); 
                    //throw new MetadataExampleFieldCreationException(String.join(messages, ' '));
                }               
            }
            else{
                if(!saveResult.success)
                {
                    getData[count].result='error';
                    getData[count].errorMsg='Request failed with no specified error.';
                    //throw new MetadataExampleFieldCreationException('Request failed with no specified error.');
                }
                
            }
            count++;
        }
        createTranslations();
    }
    
    public void createTranslations()
    {
        /*
        Map<String,Map<String,String>> allTranslations=new Map<String,Map<String,String>>();
        for(CustomLabelDS customLabel: getData)
        {
            Map<String,String> oneTranslation=new Map<String,String>();
            if(customLabel.ChineseSimplified!=null)
                oneTranslation.put('zh_CN', customLabel.ChineseSimplified);
            if(customLabel.ChineseTraditional!=null)
                oneTranslation.put('zh_TW', customLabel.ChineseTraditional);
            if(customLabel.Danish!=null)
                oneTranslation.put('da', customLabel.Danish);
            if(customLabel.Dutch!=null)
                oneTranslation.put('nl_NL', customLabel.Dutch);
            if(customLabel.English!=null)
                oneTranslation.put('en_US', customLabel.English);
            if(customLabel.Finnish!=null)
                oneTranslation.put('fi', customLabel.Finnish);
            if(customLabel.French!=null)
                oneTranslation.put('fr', customLabel.French);
            if(customLabel.German!=null)
                oneTranslation.put('de', customLabel.German);
            if(customLabel.Italian!=null)
                oneTranslation.put('it', customLabel.Italian);
            if(customLabel.Japanese!=null)
                oneTranslation.put('ja', customLabel.Japanese);
            if(customLabel.Korean!=null)
                oneTranslation.put('ko', customLabel.Korean);
            if(customLabel.Norwegian!=null)
                oneTranslation.put('no', customLabel.Norwegian);
            if(customLabel.Portuguese!=null)
                oneTranslation.put('pt_BR', customLabel.Portuguese);
            if(customLabel.Russian!=null)
                oneTranslation.put('ru', customLabel.Russian);
            if(customLabel.Spanish!=null)
                oneTranslation.put('es', customLabel.Spanish);
            if(customLabel.SpanishMexico!=null)
                oneTranslation.put('es_MX', customLabel.SpanishMexico);
            if(customLabel.Swedish!=null)
                oneTranslation.put('sv', customLabel.Swedish);
            if(customLabel.Thai!=null)
                oneTranslation.put('th', customLabel.Thai);
            
            allTranslations.put(customLabel.labelName,oneTranslation);
        }
        
        Set<String> labels=new Set<String>();
        labels=allTranslations.keySet();
        
        for(String s:labels)
        {
        	Map<String,String> translationsForCurrentLabel=allTranslations.get(s);
            
        }
        */
        
        for(CustomLabelDS customLabel: getData)
        {
            if(customLabel.ChineseSimplified!=null&&ChineseSimplified!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'zh_CN', customLabel.ChineseSimplified);
            if(customLabel.ChineseTraditional!=null&&ChineseTraditional!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'zh_TW', customLabel.ChineseTraditional);
            if(customLabel.Danish!=null&&Danish!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'da', customLabel.Danish);
            if(customLabel.Dutch!=null&&Dutch!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'nl_NL', customLabel.Dutch);
            if(customLabel.English!=null&&English!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'en_US', customLabel.English);
            if(customLabel.Finnish!=null&&Finnish!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'fi', customLabel.Finnish);
            if(customLabel.French!=null&&French!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'fr', customLabel.French);
            if(customLabel.German!=null&&German!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'de', customLabel.German);
            if(customLabel.Italian!=null&&Italian!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'it', customLabel.Italian);
            if(customLabel.Japanese!=null&&Japanese!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'ja', customLabel.Japanese);
            if(customLabel.Korean!=null&&Korean!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'ko', customLabel.Korean);
            if(customLabel.Norwegian!=null&&Norwegian!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'no', customLabel.Norwegian);
            if(customLabel.Portuguese!=null&&Portuguese!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'pt_BR', customLabel.Portuguese);
            if(customLabel.Russian!=null&&Russian!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'ru', customLabel.Russian);
            if(customLabel.Spanish!=null&&Spanish!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'es', customLabel.Spanish);
            if(customLabel.SpanishMexico!=null&&SpanishMexico!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'es_MX', customLabel.SpanishMexico);
            if(customLabel.Swedish!=null&&Swedish!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'sv', customLabel.Swedish);
            if(customLabel.Thai!=null&&Thai!=false)
                MetadataApi.createTranslationsForCustomLabels(customLabel.labelName,'th', customLabel.Thai);
        }
        
        
    }
     public String getLabelString(String labelName ){
        Component.Apex.OutputText output = new Component.Apex.OutputText();
        output.expressions.value = '{!$Label.' + labelName + '}';
        
        return String.valueOf(output.value);
    }
    
    public PageReference onClickDelete(){
        Integer index = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        List<CustomLabelDS> dsToRemove = new List<CustomLabelDS>();
        if(getData[index-1] != null){
            //System.debug('@DS***:'+getData[index-1].fieldType);
            getData.remove(index-1);
        }
        //PageReference pageref = new PageReference('/apex/MetaDataPageUITest');
        return null;
    }
    
    public PageReference addNewRowInTable(){
        Map<String, List<String>> objectLayoutMap=new  Map<String, List<String>>();
        CustomLabelDS ds=new CustomLabelDS();
        
        //UtilityClass.changeStructure(ds);
        getData.add(ds);
        return null;
    }
    
    public void previewData()
    {
       parseJSONString();    
    } 
    public void parseJSONString() 
    {
        String jsonStr = myString;
        if(jsonStr!=null && jsonStr!='' )
        {
            JSONParser parser = JSON.createParser(jsonStr);
            while (parser.nextToken() != null) 
            {
                if (parser.getCurrentToken() == JSONToken.START_ARRAY) 
                {
                    while (parser.nextToken() != null) 
                    {
                        if (parser.getCurrentToken() == JSONToken.START_OBJECT) 
                        {
                            CustomLabelDS cl = (CustomLabelDS)parser.readValueAsStrict(CustomLabelDS.class);
                            //System.debug(cl.ChineseSimplified);
                            getData.add(cl);
                           	String s = JSON.serialize(cl);
                            //system.debug('Serialized CustomLabel: ' + s);
                            parser.skipChildren();
                        }
                    }
                }
            }
            
            fieldsPresent.remove('attributes');
        }
        for(CustomLabelDS customLabel: getData)
        {
            customLabel.language='en_US';
        }
            
        
        //System.debug(getData.isEmpty());

    } 
     
}