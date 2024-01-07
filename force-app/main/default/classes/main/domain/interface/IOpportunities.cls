public interface IOpportunities extends fflib_ISObjects {
  List<Opportunity> getOpportunities();
  Map<ID, Opportunity> getOpportunitiesMap();
  void ClosedWonCreateTask(fflib_ISObjectUnitOfWork theUnitOfWork);
}
