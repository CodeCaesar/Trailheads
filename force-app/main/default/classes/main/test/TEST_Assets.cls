@IsTest
private class TEST_Assets {
  @TestSetup
  static void makeData() {
    ATK.prepare(Account.SObjectType, 1)
      .field(Account.Name)
      .index('Name-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 1)
      .field(Contact.LastName)
      .repeat('Adams', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .also()
      .withChildren(Asset.SObjectType, Asset.AccountId, 1)
      .field(Asset.Name)
      .repeat('TrailheadTest')
      .field(Asset.Asset_Identifier__c)
      .repeat('trailheadtestrecord')
      .save();
  }
  @isTest
  static void tempTest() {
    IAssets theseAsset = Assets.newInstance(
      AssetsSelector.newInstance()
        .selectAssetIdentifier(new List<String>{ 'trailheadtestrecord' })
    );
    AssetService.reportLostDevice('trailheadtestrecord');
  }

  //   @isTest
  //   static void testNoCountryCode() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Regulated zones only', responseString);
  //   }
  //   @isTest
  //   static void testCountryCodeBlank() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', '');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Regulated zones only', responseString);
  //   }

  //   @isTest
  //   static void testCountryCodeAU() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', 'AU');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Authorized zones only', responseString);
  //   }

  //   @isTest
  //   static void testCountryCodeDNE() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', 'UK');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Confirm with the local authorities', responseString);
  //   }

  //   @isTest
  //   static void testProductDoesNotExist() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', '12XU');
  //     request.addHeader('CountryCode', 'US');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('ProductCode is missing or doesn\'t exist', responseString);
  //   }
  //   @isTest
  //   static void testProductGeoMappingsDoesNotExist() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC8900');
  //     request.addHeader('CountryCode', 'US');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Confirm with the local authorities', responseString);
  //   }
}
