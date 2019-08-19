public class RestApiDemo {
    
    
    static final String USERNAME     = 'training.vishal@salesforce.com';
    static final String PASSWORD     = 'training@123';
    static final String LOGINURL     = ' https://login.salesforce.com';
    static final String GRANTSERVICE = '/services/oauth2/authorize?grant_type=password';
    static final String CLIENTID     = '3MVG9d8..z.hDcPLoz63ulL8E6famOeIsunCNFxz4HYW0oBNSlb9XwDam0rDMXYiP9fYleuAsuSKREpt3wJ_8';
    static final String CLIENTSECRET = '8358226602628171340';
    
    static final String finalURL = 'https://ap5.salesforce.com/services/oauth2/token?grant_type=password&client_id='+CLIENTID+'&client_secret='+CLIENTSECRET+'&username='+USERNAME+'&password='+PASSWORD;
    
    private static String getAccessToken() {                
        HttpRequest request = new HttpRequest();
        request.setEndpoint(finalURL);
        request.setMethod('POST');
        HttpResponse response = new Http().send(request);
        if(response.getStatusCode() == 200){
             AuthorizationWrapper result = new AuthorizationWrapper();
            try{
                result = (AuthorizationWrapper)Json.deserialize(response.getBody(), AuthorizationWrapper.class);
            }Catch(Exception ex){
                
            }
            return result.access_token;
        }
        return null;
    }
    
    public static void invokeRestMethods(){
        String access_token = getAccessToken();
        String endpoint = 'https://ap5.salesforce.com/services/apexrest/v2/accounts/0017F000007x1Iy';
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer '+access_token);
        HttpResponse response = new Http().send(request);
        System.debug(response.getBody());
    } 
    
    private static void sendEmail(String body){            
        Messaging.reserveSingleEmailCapacity(2);        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                
        String[] toAddresses = new String[] {'vishal.ranjan@nagarro.com'};             
        mail.setToAddresses(toAddresses);        
        mail.setReplyTo('support@acme.com');        
        mail.setSenderDisplayName('Salesforce Support');        
        mail.setSubject('Response');        
        mail.setBccSender(false);        
        mail.setUseSignature(false);                
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    
    public class AuthorizationWrapper{
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
    }
}