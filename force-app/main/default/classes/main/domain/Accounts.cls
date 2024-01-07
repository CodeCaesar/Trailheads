public class Accounts extends fflib_SObjects implements IAccounts {
  public static IAccounts newInstance(List<Account> recordList) {
    return (IAccounts) Application.Domain.newInstance(recordList);
  }

  public static IAccounts newInstance(Set<Id> recordIdSet) {
    return (IAccounts) Application.Domain.newInstance(recordIdSet);
  }

  public Accounts(List<Account> sObjectList) {
    super(sObjectList, Schema.Account.SObjectType);
  }

  public List<Account> getAccounts() {
    return (List<Account>) getRecords();
  }

  public Map<ID, Account> getAccountsMap() {
    return new Map<ID, Account>(getAccounts());
  }

  public Map<ID, List<Contact>> getAccountsContactsMap() {
    Map<ID, List<Contact>> accountsContactsMap = new Map<ID, List<Contact>>();
    for (Account thisAccount : getAccounts()) {
      for (Contact thisContact : thisAccount.Contacts) {
        if (accountsContactsMap.get(thisAccount.ID) == null) {
          accountsContactsMap.put(
            thisAccount.ID,
            new List<Contact>{ thisContact }
          );
        } else {
          accountsContactsMap.get(thisAccount.ID).add(thisContact);
        }
      }
    }
    return accountsContactsMap;
  }

  public void matchBillingAddressPostalCode(
    fflib_ISObjectUnitOfWork theUnitOfWork
  ) {
    for (Account thisAccount : getAccounts()) {
      if (thisAccount.Match_Billing_Address__c) {
        thisAccount.ShippingPostalCode = thisAccount.BillingPostalCode;
        //theUnitOfWork.registerDirty(thisAccount);
      }
    }
  }

  public void setNumberOfContacts(fflib_ISObjectUnitOfWork theUnitOfWork) {
    Map<ID, List<Contact>> accountsContactsMap = getAccountsContactsMap();
    Map<ID, Account> accountMap = getAccountsMap();
    for (ID theAccountID : accountsContactsMap.keySet()) {
      accountMap.get(theAccountID)
        .Number_Of_Contacts__c = accountsContactsMap.get(theAccountID).size();
      theUnitOfWork.registerDirty(accountMap.get(theAccountID));
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Accounts((List<SObject>) objectList);
    }
  }
}
