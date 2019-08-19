public class switchStructure {
    public string ObjectName {get;set;}
    public string  ElementName {get;set;}
    public string  FullName {get;set;}
    public string  Type {get;set;}
    public boolean isActive {get;set;}
    public enum MetadataType {WORKFLOWRULE,VALIDATIONRULE}
    public string triggerBody{get;set;}
}