@IsTest
private class AccountManagerTest {
  @TestSetup
  static void makeData() {
    ATK.prepare(Account.SObjectType, 10)
      .field(Account.Name)
      .index('Name-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 1)
      .field(Contact.LastName)
      .repeat('Adams', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
  }
  @isTest
  static void testGetAccountById() {
    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance().selectAll()
    );
    // Set up a test request
    RestRequest request = new RestRequest();
    request.requestUri =
      'https://curious-moose-gml33v-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/' +
      theseAccounts.getAccounts()[0].ID +
      '/contacts';
    request.httpMethod = 'GET';
    RestContext.request = request;
    // Call the method to test
    Account thisAccount = AccountManager.getAccount();
    System.debug(thisAccount.Contacts);
    System.debug(theseAccounts.getAccounts()[0].Contacts);
    // Verify results
    Assert.areEqual(theseAccounts.getAccounts()[0].Name, thisAccount.Name);
  }
}
