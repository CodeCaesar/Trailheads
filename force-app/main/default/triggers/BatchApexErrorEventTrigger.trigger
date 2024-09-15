trigger BatchApexErrorEventTrigger on BatchApexErrorEvent(after insert) {
  fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
  IBatchApexErrorEvents theseBatchApexErrorEvents = BatchApexErrorEvents.newInstance(
    Trigger.new
  );
  theseBatchApexErrorEvents.processBatchApexErrorEvents(theUnitOfWork);
  theUnitOfWork.commitWork();
}