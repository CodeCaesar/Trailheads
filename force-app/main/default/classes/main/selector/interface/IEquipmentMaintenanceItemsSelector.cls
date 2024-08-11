public interface IEquipmentMaintenanceItemsSelector extends fflib_ISObjectSelector {
  List<Equipment_Maintenance_Item__c> selectByMaintenanceRequest(
    Set<ID> caseIDSet
  );
}
