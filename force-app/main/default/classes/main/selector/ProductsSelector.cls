public class ProductsSelector extends fflib_SObjectSelector implements IProductsSelector {
  public static ICasesSelector newInstance() {
    return (ICasesSelector) Application.Selector.newInstance(
      Product2.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Product2.Id,
      Product2.IsActive,
      Product2.Cost__c,
      Product2.Current_Inventory__c,
      Product2.ProductCode,
      Product2.Name,
      Product2.Maintenance_Cycle__c,
      Product2.Lifespan_Months__c,
      Product2.Lifespan_Months__c,
      Product2.Replacement_Part__c,
      Product2.SourceProductId,
      Product2.Warehouse_SKU__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Product2.SObjectType;
  }

  public List<Product2> selectAll() {
    return (List<Product2>) Database.query(newQueryFactory().toSOQL());
  }
  public List<Product2> selectWithEquipmentMaintenanceItems(
    Set<ID> productIDSet
  ) {
    EquipmentMaintenanceItemsSelector thisEquipmentMaintenanceItemsSelector = new EquipmentMaintenanceItemsSelector();
    fflib_QueryFactory productQueryFactory = newQueryFactory();
    productQueryFactory.setCondition('id in: productIDSet');
    thisEquipmentMaintenanceItemsSelector.addQueryFactorySubselect(
      productQueryFactory
    );
    return Database.query(productQueryFactory.toSOQL());
  }
}
