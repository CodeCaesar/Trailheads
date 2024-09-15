public interface IProductGeoMappingSelector extends fflib_ISObjectSelector {
  List<Product_Geo_Mapping__mdt> selectByCountryAndProductFamily(
    List<String> countryCodeList,
    List<String> productFamilyList
  );
}