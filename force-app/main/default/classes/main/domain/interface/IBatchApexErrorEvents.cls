public interface IBatchApexErrorEvents {
  List<BatchApexErrorEvent> getBatchApexErrorEvents();
  Map<ID, BatchApexErrorEvent> getBatchApexErrorEventsMap();
  void processBatchApexErrorEvents(fflib_ISObjectUnitOfWork theUnitOfWork);
}