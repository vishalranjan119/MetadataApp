public class InvokeCaseManager {
    
    public static void getCaseRecordById(String caseId){
        String endpoint = 'https://na30.salesforce.com/services/apexrest/Cases/'+caseId;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse response = h.send(req);
        System.debug('response:'+response);
        System.debug(''+response.getBody());
    }

}