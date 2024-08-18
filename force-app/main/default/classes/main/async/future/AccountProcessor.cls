public class AccountProcessor {
  @future(callout=true)
  public static void countContacts(List<ID> accountIDList) {
    Set<id> idSet = new Set<id>(accountIDList);
    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance().selectWithContacts(idSet)
    );
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    theseAccounts.setNumberOfContacts(theUnitOfWork);
    System.debug(theseAccounts.getAccounts().get(0).Number_Of_Contacts__c);
    theUnitOfWork.commitWork();
  }
}
