@isTest
global class BillingCalloutServiceMock implements WebServiceMock {
  global void doInvoke(
    Object stub,
    Object request,
    Map<String, Object> response,
    String endpoint,
    String soapAction,
    String requestName,
    String responseNS,
    String responseName,
    String responseType
  ) {
    BillingServiceProxy.billProjectResponse_element theResponseElement = new BillingServiceProxy.billProjectResponse_element();
    theResponseElement.status = 'Success';
    response.put('response_x', theResponseElement);
  }
}