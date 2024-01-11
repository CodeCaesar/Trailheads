@isTest
private class AddPrimaryContactTest {
  @TestSetup
  static void makeData() {
    ATK.prepare(Account.SObjectType, 100)
      .field(Account.Name)
      .index('Name-{0000}')
      .field(Account.BillingState)
      .repeat('CA', 'NY')
      .save();
    ATK.prepare(Contact.SObjectType, 1)
      .field(Contact.LastName)
      .index('Name-{0000}')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
  }
  @IsTest
  static void testAddPrimaryContact() {
    // Arrange
    IContacts theseContacts = Contacts.newInstance(
      ContactsSelector.newInstance().selectAll()
    );
    AddPrimaryContact thisAddPrimaryContact = new AddPrimaryContact(
      theseContacts.getContacts()[0],
      'NY'
    );
    Test.startTest();
    System.enqueueJob(thisAddPrimaryContact);
    Test.stopTest();

    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance()
        .selectWithContactsByBillingStateLimit('NY', 50)
    );
    Assert.areEqual(50, theseAccounts.getAccountsContactsMap().values().size());
  }
}
