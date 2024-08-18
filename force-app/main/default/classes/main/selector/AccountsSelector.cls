public class AccountsSelector extends fflib_SObjectSelector implements IAccountsSelector {
  public static IAccountsSelector newInstance() {
    return (IAccountsSelector) Application.Selector.newInstance(
      Account.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Account.Id,
      Account.BillingAddress,
      Account.BillingStreet,
      Account.BillingCity,
      Account.BillingState,
      Account.BillingPostalCode,
      Account.BillingCountry,
      Account.BillingStreet,
      Account.ShippingAddress,
      Account.ShippingStreet,
      Account.ShippingCity,
      Account.ShippingState,
      Account.ShippingPostalCode,
      Account.ShippingCountry,
      Account.ShippingStreet,
      Account.Match_Billing_Address__c,
      Account.Name,
      Account.Description,
      Account.Phone,
      Account.Number_Of_Contacts__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Account.SObjectType;
  }

  public List<Account> selectAll() {
    return (List<Account>) Database.query(newQueryFactory().toSOQL());
  }

  public List<Account> selectWithContacts(Set<ID> accountIDSet) {
    ContactsSelector contactSelect = new ContactsSelector();
    fflib_QueryFactory accountQueryFactory = newQueryFactory();
    accountQueryFactory.setCondition('id in: accountIDSet');
    contactSelect.addQueryFactorySubselect(accountQueryFactory);
    return Database.query(accountQueryFactory.toSOQL());
  }
  public List<Account> selectWithContactsByBillingStateLimit(
    String theBillingState,
    Integer recordLimit
  ) {
    ContactsSelector contactSelect = new ContactsSelector();
    fflib_QueryFactory queryFactory = new fflib_QueryFactory(
      Account.SObjectType
    );
    queryFactory.setCondition('BillingState =: theBillingState');
    queryFactory.setLimit(recordLimit);
    contactSelect.addQueryFactorySubselect(queryFactory);
    return Database.query(queryFactory.toSOQL());
  }
}
