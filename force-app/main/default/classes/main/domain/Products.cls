public class Products extends fflib_SObjects implements IProducts {
  private static List<Product_Geo_Mapping__mdt> PROUCTGEOMAPPINGLIST;
  private static List<String> COUNTRYCODELIST;
  private static List<String> PRODUCTFAMILYLIST;
  public static IProducts newInstance(List<Product2> recordList) {
    return (IProducts) Application.Domain.newInstance(recordList);
  }

  public static IProducts newInstance(Set<Id> recordIdSet) {
    return (IProducts) Application.Domain.newInstance(recordIdSet);
  }

  public Products(List<Product2> sObjectList) {
    super(sObjectList, Schema.Product2.SObjectType);
  }

  public List<Product2> getProducts() {
    return (List<Product2>) getRecords();
  }

  public Map<ID, Product2> getProductsMap() {
    return new Map<ID, Product2>(getProducts());
  }

  public void setCountryCodeList(List<String> countyCodeList) {
    COUNTRYCODELIST = countyCodeList;
  }

  private void setProductFamilyList() {
    if (PRODUCTFAMILYLIST == null) {
      PRODUCTFAMILYLIST = new List<String>();
      for (Product2 thisProduct : getProducts()) {
        PRODUCTFAMILYLIST.add(thisProduct.Family);
      }
    }
  }

  public List<Product_Geo_Mapping__mdt> getProductGeoMappingList() {
    setProductFamilyList();
    if (PROUCTGEOMAPPINGLIST != null)
      return PROUCTGEOMAPPINGLIST;
    if (COUNTRYCODELIST == null)
      COUNTRYCODELIST = new List<String>{ 'US' };
    if (PRODUCTFAMILYLIST == null)
      PRODUCTFAMILYLIST = new List<String>();
    return ProductGeoMappingSelector.newInstance()
      .selectByCountryAndProductFamily(COUNTRYCODELIST, PRODUCTFAMILYLIST);
  }

  public Map<ID, List<Equipment_Maintenance_Item__c>> getProduct2sEquipmentMaintenanceItemsMap() {
    Map<ID, List<Equipment_Maintenance_Item__c>> ProductsEquipmentMaintenanceItemsMap = new Map<ID, List<Equipment_Maintenance_Item__c>>();
    for (Product2 thisProduct2 : getProducts()) {
      for (
        Equipment_Maintenance_Item__c thisEquipmentMaintenanceItem : thisProduct2.Equipment_Maintenance_Items__r
      ) {
        if (ProductsEquipmentMaintenanceItemsMap.get(thisProduct2.ID) == null) {
          ProductsEquipmentMaintenanceItemsMap.put(
            thisProduct2.ID,
            new List<Equipment_Maintenance_Item__c>{
              thisEquipmentMaintenanceItem
            }
          );
        } else {
          ProductsEquipmentMaintenanceItemsMap.get(thisProduct2.ID)
            .add(thisEquipmentMaintenanceItem);
        }
      }
    }
    return ProductsEquipmentMaintenanceItemsMap;
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Products((List<SObject>) objectList);
    }
  }
}