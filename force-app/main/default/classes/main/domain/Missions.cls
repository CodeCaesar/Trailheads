public class Missions extends fflib_SObjects implements IMissions {
  private Database.BatchableContext THEBATCHABLECONTEXT;
  public static IMissions newInstance(List<Mission__c> recordList) {
    return (IMissions) Application.Domain.newInstance(recordList);
  }

  public static IMissions newInstance(Set<Id> recordIdSet) {
    return (IMissions) Application.Domain.newInstance(recordIdSet);
  }

  public Missions(List<Mission__c> sObjectList) {
    super(sObjectList, Schema.Mission__c.SObjectType);
  }

  public List<Mission__c> getMissions() {
    return (List<Mission__c>) getRecords();
  }

  public Map<ID, Mission__c> getMissionsMap() {
    return new Map<ID, Mission__c>(getMissions());
  }

  public void setBatchableContext(
    Database.BatchableContext theBatchableContext
  ) {
    this.THEBATCHABLECONTEXT = theBatchableContext;
  }

  public void updatePilotRatings(fflib_ISObjectUnitOfWork theUnitOfWork) {
    for (Mission__c thisMission : getMissions()) {
      try {
        Double weightedCompletionRate = 0.3 * thisMission.Completion_Rating__c;
        Double weightedSafetyIncidents = -0.5 * thisMission.Safety_Incidents__c;

        Double newOverallRating =
          thisMission.Pilot__r.Pilot_Rating__c + thisMission.Overall_Rating__c;
        thisMission.Pilot__r.Pilot_Rating__c = newOverallRating;
        theUnitOfWork.registerDirty(thisMission.Pilot__r);
      } catch (Exception exe) {
        Error_Log__c thisErrorLog = new Error_Log__c(
          Name = 'PilotRatingBatch' + THEBATCHABLECONTEXT.getJobId(),
          Async_Apex_Job_Id__c = THEBATCHABLECONTEXT.getJobId(),
          Message__c = 'Errorr Running Batch PilotRatingBatch',
          Stacktrace__c = String.valueOf(exe)
        );
        theUnitOfWork.registerNew(thisErrorLog);
      }
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Missions((List<SObject>) objectList);
    }
  }
}