public class Opportunities extends fflib_SObjects implements IOpportunities {
  public static IOpportunities newInstance(List<Opportunity> recordList) {
    return (IOpportunities) Application.Domain.newInstance(recordList);
  }

  public static IOpportunities newInstance(Set<Id> recordIdSet) {
    return (IOpportunities) Application.Domain.newInstance(recordIdSet);
  }

  public Opportunities(List<Opportunity> sObjectList) {
    super(sObjectList, Schema.Account.SObjectType);
  }

  public List<Opportunity> getOpportunities() {
    return (List<Opportunity>) getRecords();
  }

  public Map<ID, Opportunity> getOpportunitiesMap() {
    return new Map<ID, Opportunity>(getOpportunities());
  }

  public void ClosedWonCreateTask(fflib_ISObjectUnitOfWork theUnitOfWork) {
    for (Opportunity thisOpportunity : getOpportunities()) {
      if (thisOpportunity.StageName.equalsIgnoreCase('Closed Won')) {
        Task thisTask = new Task();
        thisTask.Subject = 'Follow Up Test Task';
        thisTask.WhatId = thisOpportunity.ID;
        theUnitOfWork.registerNew(thisTask);
      }
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Opportunities((List<SObject>) objectList);
    }
  }
}
