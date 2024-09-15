public class BatchApexErrorEvents extends fflib_SObjects implements IBatchApexErrorEvents {
  public static IBatchApexErrorEvents newInstance(
    List<BatchApexErrorEvent> recordList
  ) {
    return (IBatchApexErrorEvents) Application.Domain.newInstance(recordList);
  }

  public static IBatchApexErrorEvents newInstance(Set<Id> recordIdSet) {
    return (IBatchApexErrorEvents) Application.Domain.newInstance(recordIdSet);
  }

  public BatchApexErrorEvents(List<BatchApexErrorEvent> sObjectList) {
    super(sObjectList, Schema.BatchApexErrorEvent.SObjectType);
  }

  public List<BatchApexErrorEvent> getBatchApexErrorEvents() {
    return (List<BatchApexErrorEvent>) getRecords();
  }

  public Map<ID, BatchApexErrorEvent> getBatchApexErrorEventsMap() {
    return new Map<ID, BatchApexErrorEvent>(getBatchApexErrorEvents());
  }

  public void processBatchApexErrorEvents(
    fflib_ISObjectUnitOfWork theUnitOfWork
  ) {
    for (BatchApexErrorEvent errorEvent : getBatchApexErrorEvents()) {
      Error_Log__c errorLog = new Error_Log__c();
      errorLog.Message__c = errorEvent.Message;
      errorLog.StackTrace__c = errorEvent.StackTrace;
      errorLog.Async_Apex_Job_Id__c = errorEvent.AsyncApexJobId;
      theUnitOfWork.registerNew(errorLog);
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new BatchApexErrorEvents((List<SObject>) objectList);
    }
  }
}