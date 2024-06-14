public class ProductGeoMappingSelector extends fflib_SObjectSelector implements IProductGeoMappingSelector {
  public static IProductGeoMappingSelector newInstance() {
    return (IProductGeoMappingSelector) Application.Selector.newInstance(
      Product_Geo_Mapping__mdt.SObjectType
    );
  }

  public Schema.SObjectType getSObjectType() {
    return Product_Geo_Mapping__mdt.SObjectType;
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Product_Geo_Mapping__mdt.Id,
      Product_Geo_Mapping__mdt.MasterLabel,
      Product_Geo_Mapping__mdt.Country_Code__c,
      Product_Geo_Mapping__mdt.Permissible_Fly_Zone__c,
      Product_Geo_Mapping__mdt.Product_Family__c
    };
  }

  public List<Product_Geo_Mapping__mdt> selectByCountryAndProductFamily(
    List<String> countryCodeList,
    List<String> productFamilyList
  ) {
    fflib_QueryFactory queryFactory = newQueryFactory()
      .setCondition(
        'Country_Code__c IN :countryCodeList AND Product_Family__c IN :productFamilyList'
      );
    System.debug(queryFactory.toSOQL());
    return (List<Product_Geo_Mapping__mdt>) Database.query(
      queryFactory.toSOQL()
    );
  }
}
