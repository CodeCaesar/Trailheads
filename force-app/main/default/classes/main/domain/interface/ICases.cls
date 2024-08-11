public interface ICases extends fflib_ISObjects {
  List<Case> getCases();
  Map<ID, Case> getCasesMap();
  Map<ID, List<Equipment_Maintenance_Item__c>> getCasesEquipmentMaintenanceItemsMap();
  Set<ID> getProductIDSet();
  void generateMaintenanceRequests(fflib_ISObjectUnitOfWork theUnitOfWork);
  Integer calculateMaintenenceCycle(ID CaseID);
}
