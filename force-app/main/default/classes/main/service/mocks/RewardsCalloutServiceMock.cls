@isTest
global class RewardsCalloutServiceMock implements HttpCalloutMock {
  global HTTPResponse respond(HTTPRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json');
    response.setStatusCode(201);
    return response;
  }
}