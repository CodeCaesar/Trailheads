public interface IProducts extends fflib_ISObjects {
  List<Product2> getProducts();
  Map<ID, Product2> getProductsMap();
  Map<ID, List<Equipment_Maintenance_Item__c>> getProduct2sEquipmentMaintenanceItemsMap();
  List<Product_Geo_Mapping__mdt> getProductGeoMappingList();
  void setCountryCodeList(List<String> countyCodeList);
}
