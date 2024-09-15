public class CaseTriggerHandler extends fflib_SObjectDomain {
  static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
  private static Boolean hasRun = false;
  public CaseTriggerHandler(List<Account> sObjectList) {
    super(sObjectList);
  }

  public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
    Set<ID> caseIdSet = new Set<ID>();
    if (!hasRun) {
      for (Case thisCase : (List<Case>) Records) {
        Case existingCase = (Case) existingRecords.get(thisCase.Id);
        if (
          thisCase.isClosed == true &&
          existingCase.isClosed == false &&
          thisCase.Status == 'Closed' &&
          existingCase.Status != null
        ) {
          if (
            thisCase.Type.equalsIgnoreCase('Routine Maintenance') ||
            thisCase.Type.equalsIgnoreCase('Repair')
          ) {
            caseIdSet.add(thisCase.ID);
          }
        }
      }

      if (caseIdSet.size() > 0) {
        ICases theseCases = Cases.newInstance(
          CasesSelector.newInstance()
            .selectWithMaintenanceRequestsAndProducts(caseIDSet)
        );
        theseCases.generateMaintenanceRequests(theUnitOfWork);
        theUnitOfWork.commitWork();
      }
    }
    hasRun = true;
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new CaseTriggerHandler(sObjectList);
    }
  }
}