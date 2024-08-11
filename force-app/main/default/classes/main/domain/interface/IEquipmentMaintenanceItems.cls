public interface IEquipmentMaintenanceItems extends fflib_ISObjects {
  List<Equipment_Maintenance_Item__c> getEquipmentMaintenanceItems();
  Map<ID, Equipment_Maintenance_Item__c> getEquipmentMaintenanceItemsMap();
}
