public interface IMissions {
  List<Mission__c> getMissions();
  Map<ID, Mission__c> getMissionsMap();

  void setBatchableContext(Database.BatchableContext theBatchableContext);

  void updatePilotRatings(fflib_ISObjectUnitOfWork theUnitOfWork);
}