@isTest
global class CalloutWPMock implements HttpCalloutMock {
    // Should implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"type": "not valid type"}');
        response.setStatusCode(500);
        return response; 
    }
}