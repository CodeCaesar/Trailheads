public class CaseTriggerHandler extends fflib_SObjectDomain {
  static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
  private static boolean hasRun = false;
  private static boolean hasRunUpdate = false;

  public CaseTriggerHandler(List<Case> sObjectList) {
    // Domain classes are initialised with lists to enforce bulkification throughout
    super(sObjectList);
  }
  public override void onAfterInsert() {
    if (!hasRun) {
      List<Case> casesToUpdate = new List<Case>();
      for (Case thisCase : (List<Case>) Records) {
        if (thisCase.Status.equalsIgnoreCase('Closed')) {
          if (
            thisCase.Type.endsWithIgnoreCase('Repair') ||
            thisCase.Type.endsWithIgnoreCase('Routine Maintenance')
          ) {
            casesToUpdate.add(thisCase);
          }
        }
      }
      ICases theseCases = Cases.newInstance(casesToUpdate);
    }
    hasRun = true;
  }

  public override void onAfterUpdate(Map<Id, SObject> existingRecords) {
    // if (!hasRunUpdate) {
      List<Case> casesToUpdate = new List<Case>();
      for (Case thisCase : (List<Case>) Records) {
        Case existingCase = (Case) existingRecords.get(thisCase.Id);
        if (
          thisCase.Status.equalsIgnoreCase('Closed') &&
          !existingCase.Status.equalsIgnoreCase('Closed')
        ) {
          if (
            thisCase.Type.equalsIgnoreCase('Repair') ||
            thisCase.Type.equalsIgnoreCase('Routine Maintenance')
          ) {
            casesToUpdate.add(thisCase);
          }
        }
      }
      ICases theseCases = Cases.newInstance(casesToUpdate);
    // }
    // hasRunUpdate = true;
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new CaseTriggerHandler(sObjectList);
    }
  }
}
