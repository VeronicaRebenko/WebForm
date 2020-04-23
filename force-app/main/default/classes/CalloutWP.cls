public class CalloutWP {
    
    @future(callout=true)
    public static void makeCallout(String type, String address) {
        
        try{     
            HttpRequest request = new HttpRequest();
            
            String endpoint = 'http://wpBorn2Invest/freezepage/';
            
            String userName = 'admin';
            String password = null;
            Blob headerValue = Blob.valueOf(userName + ':' + password);
            String authorizationHeader = 'Basic YWRtaW46 ' + EncodingUtil.base64Encode(headerValue);
            
            String stringBody = '{ \"type\":\"' +type+ '\", \"address\":\"' +address+ '\"}'; 
            
            request.setHeader('Authorization', authorizationHeader);             
            request.setHeader('Accept', 'application/json');  
            request.setHeader('Content-Type', 'application/json'); 
            request.setBody(stringBody);           
            request.setEndPoint(endpoint);
            request.setMethod('POST');
            
            HttpResponse response = new HTTP().send(request);
            
            System.debug('WP Response:'+ response.getStatusCode());
            
            if (response.getStatusCode() != 200) { 
				system.debug('WP Response Error:' + response.getStatusCode());         
            }     
            
        } catch(Exception e){
            System.debug('Error:'+e.getMessage());
        }
    }   
}