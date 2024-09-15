@IsTest
private class TEST_Products {
  @TestSetup
  static void makeData() {
    ATK.prepare(Account.SObjectType, 10)
      .field(Account.Name)
      .index('Name-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 1)
      .field(Contact.LastName)
      .repeat('Adams', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();

    ATK.prepare(Product2.SObjectType, 2)
      .field(Product2.Name)
      .repeat('GenWatt Propane 500kW')
      .field(Product2.ProductCode)
      .repeat('GC1040', 'GC8900')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Family)
      .repeat('Fixed-Wing', 'Gundam-Wing')
      .save();
  }
  @isTest
  static void testNoProductCode() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('CountryCode', 'US');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('ProductCode is missing or doesn\'t exist', responseString);
  }

  @isTest
  static void testNoCountryCode() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', 'GC1040');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('Regulated zones only', responseString);
  }
  @isTest
  static void testCountryCodeBlank() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', 'GC1040');
    request.addHeader('CountryCode', '');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('Regulated zones only', responseString);
  }

  @isTest
  static void testCountryCodeAU() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', 'GC1040');
    request.addHeader('CountryCode', 'AU');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('Authorized zones only', responseString);
  }

  @isTest
  static void testCountryCodeDNE() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', 'GC1040');
    request.addHeader('CountryCode', 'UK');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('Confirm with the local authorities', responseString);
  }

  @isTest
  static void testProductDoesNotExist() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', '12XU');
    request.addHeader('CountryCode', 'US');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('ProductCode is missing or doesn\'t exist', responseString);
  }
  @isTest
  static void testProductGeoMappingsDoesNotExist() {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';
    request.addParameter('ProductCode', 'GC8900');
    request.addHeader('CountryCode', 'US');
    RestContext.request = request;
    // Call the method to test
    String responseString = ProductZoningService.handleRequest();
    System.debug(responseString);
    // Verify results
    Assert.areEqual('Confirm with the local authorities', responseString);
  }
}