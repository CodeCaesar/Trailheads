public inherited sharing class AccountTriggerHandler extends fflib_SObjectDomain {
  public AccountTriggerHandler(List<Opportunity> sObjectList) {
    // Domain classes are initialised with lists to enforce bulkification throughout
    super(sObjectList);
  }

  public override void onBeforeInsert() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    IAccounts theseAccounts = Accounts.newInstance((List<Account>) Records);
    theseAccounts.matchBillingAddressPostalCode(theUnitOfWork);
    theUnitOfWork.commitWork();
  }

  public override void onBeforeUpdate(Map<Id, SObject> existingAccountMap) {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();

    IAccounts theseAccounts = Accounts.newInstance(
      (List<Account>) this.records
    );
    theseAccounts.matchBillingAddressPostalCode(theUnitOfWork);
    theUnitOfWork.commitWork();
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new AccountTriggerHandler(sObjectList);
    }
  }
}
