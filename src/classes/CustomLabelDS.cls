public class CustomLabelDS {
    
    public CustomLabelDS()
    {
        errorMap = new Map<integer,boolean>();
        for(Integer i=1; i<=25;i++)
            errorMap.put(i,false);
        
        language='en_US';
    }
    public String shortDesc{get;set;}
	public String labelName{get;set;}
    public String labelProt{get;set;}
    public String categories{get;set;}
    public String labelValue{get;set;}
    public String ChineseSimplified{get;set;}
    public String ChineseTraditional{get;set;}
	public String Danish{get;set;}
    public String Dutch{get;set;}
    public String English{get;set;}
    public String Finnish{get;set;}
    public String French{get;set;}
    public String German{get;set;}
    public String Italian{get;set;}
    public String Japanese{get;set;}
    public String Korean{get;set;}
    public String Norwegian{get;set;}
    public String Portuguese{get;set;}
    public String Russian{get;set;}
    public String Spanish{get;set;}
    public String SpanishMexico{get;set;}
    public String Swedish{get;set;}
    public String Thai{get;set;}
    public String language{get;set;}
    public String result{get;set;}
    public String errorMsg{get;set;}
    public Map<integer,boolean> errorMap {get;set;}
    public Boolean isDeletable{get;set;}
    
}