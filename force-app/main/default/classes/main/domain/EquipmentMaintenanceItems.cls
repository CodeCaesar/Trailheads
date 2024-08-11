public class EquipmentMaintenanceItems extends fflib_SObjects implements IEquipmentMaintenanceItems {
  public static IEquipmentMaintenanceItems newInstance(
    List<Equipment_Maintenance_Item__c> recordList
  ) {
    return (IEquipmentMaintenanceItems) Application.Domain.newInstance(
      recordList
    );
  }

  public static IEquipmentMaintenanceItems newInstance(Set<Id> recordIdSet) {
    return (IEquipmentMaintenanceItems) Application.Domain.newInstance(
      recordIdSet
    );
  }

  public EquipmentMaintenanceItems(
    List<Equipment_Maintenance_Item__c> sObjectList
  ) {
    super(sObjectList, Schema.Equipment_Maintenance_Item__c.SObjectType);
  }

  public List<Equipment_Maintenance_Item__c> getEquipmentMaintenanceItems() {
    return (List<Equipment_Maintenance_Item__c>) getRecords();
  }

  public Map<ID, Equipment_Maintenance_Item__c> getEquipmentMaintenanceItemsMap() {
    return new Map<ID, Equipment_Maintenance_Item__c>(
      getEquipmentMaintenanceItems()
    );
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new EquipmentMaintenanceItems((List<SObject>) objectList);
    }
  }
}
