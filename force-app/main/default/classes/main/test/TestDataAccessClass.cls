@IsTest(SeeAllData=true)
public class TestDataAccessClass {
  // This test accesses an existing account.
  // It also creates and accesses a new test account.
  @IsTest
  static void myTestMethod1() {
    Map<ID, Case> caseMap = new Map<ID, Case>(
      [SELECT ID FROM Case WHERE ID = '500Hp00001fd4ivIAA']
    );
    ICases theseCases = Cases.newInstance(
      CasesSelector.newInstance()
        .selectWithMaintenanceRequestsAndProducts(caseMap.keySet())
    );
    System.debug(theseCases.getCases()[0].Equipment_Maintenance_Items__r);
  }
}
