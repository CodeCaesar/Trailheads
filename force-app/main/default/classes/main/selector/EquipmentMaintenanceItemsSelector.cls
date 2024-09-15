public class EquipmentMaintenanceItemsSelector extends fflib_SObjectSelector implements IEquipmentMaintenanceItemsSelector {
  public static IEquipmentMaintenanceItemsSelector newInstance() {
    return (IEquipmentMaintenanceItemsSelector) Application.Selector.newInstance(
      Equipment_Maintenance_Item__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Equipment_Maintenance_Item__c.Id,
      Equipment_Maintenance_Item__c.Equipment__c,
      Equipment_Maintenance_Item__c.Maintenance_Request__c,
      Equipment_Maintenance_Item__c.Name,
      Equipment_Maintenance_Item__c.Quantity__c,
      Equipment_Maintenance_Item__c.Maintenance_Cycle__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Equipment_Maintenance_Item__c.SObjectType;
  }

  public List<Equipment_Maintenance_Item__c> selectAll() {
    return (List<Equipment_Maintenance_Item__c>) Database.query(
      newQueryFactory().toSOQL()
    );
  }

  public List<Equipment_Maintenance_Item__c> selectByMaintenanceRequest(
    Set<ID> caseIDSet
  ) {
    return (List<Equipment_Maintenance_Item__c>) Database.query(
      newQueryFactory()
        .setCondition('Maintenance_Request__c in: caseIDSet')
        .toSOQL()
    );
  }
}