@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
  @HttpGet
  // e.g. https://*.lightning.force.com/services/apexrest/ProductZoning/?ProductCode=GC1020
  global static String handleRequest() {
    System.debug('Hello World');
    RestRequest thisRequest = RestContext.request;
    RestResponse thisResponse = RestContext.response;
    System.debug(thisRequest.params);
    System.debug(thisRequest.requestURI);
    // Log the request headers

    String[] uriParts = thisRequest.requestURI.split('/');
    String ProductCode = thisRequest.params.get('ProductCode');
    if (ProductCode == null || ProductCode.equalsIgnoreCase(''))
      return 'ProductCode is missing or doesn\'t exist';
    List<String> countryCodeList = new List<String>();
    Set<String> countrySet = new Set<String>{ 'US', 'AU', 'DE', 'FR', '' };
    if (
      thisRequest.headers.get('CountryCode') != null &&
      !thisRequest.headers.get('CountryCode').equalsIgnoreCase('')
    ) {
      if (!countrySet.contains(thisRequest.headers.get('CountryCode')))
        return 'Confirm with the local authorities';
      countryCodeList.add(thisRequest.headers.get('CountryCode'));
    } else {
      countryCodeList.add('US');
    }
    System.debug(countryCodeList);
    IProducts theseProducts = Products.newInstance(
      ProductsSelector.newInstance()
        .selectByProductCode(new List<String>{ ProductCode })
    );
    if (theseProducts.getProducts().size() == 0)
      return 'ProductCode is missing or doesn\'t exist';

    System.debug(theseProducts.getProducts());
    theseProducts.setCountryCodeList(countryCodeList);
    List<Product_Geo_Mapping__mdt> selectByCountryAndProductFamily = theseProducts.getProductGeoMappingList();
    if (selectByCountryAndProductFamily.size() > 0) {
      return String.valueOf(
          selectByCountryAndProductFamily[0].Permissible_Fly_Zone__c
        ) + ' zones only';
    }
    return 'Confirm with the local authorities';
  }
}
