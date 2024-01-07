public inherited sharing class OpportunityTriggerHandler extends fflib_SObjectDomain {
  public OpportunityTriggerHandler(List<Opportunity> sObjectList) {
    // Domain classes are initialised with lists to enforce bulkification throughout
    super(sObjectList);
  }
  public override void onAfterInsert() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    IOpportunities theseOpportunities = Opportunities.newInstance(
      (List<Opportunity>) Records
    );
    theseOpportunities.ClosedWonCreateTask(theUnitOfWork);
    theUnitOfWork.commitWork();
  }

  public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    IOpportunities theseOpportunities = Opportunities.newInstance(
      (List<Opportunity>) Records
    );
    theseOpportunities.ClosedWonCreateTask(theUnitOfWork);
    theUnitOfWork.commitWork();
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new OpportunityTriggerHandler(sObjectList);
    }
  }
}
