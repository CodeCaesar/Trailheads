@IsTest
private class AccountProcessorTest {
  @IsTest
  static void testAccountrProcessor() {
    // ATK.prepare(Account.SObjectType, 10)
    // .field(Account.Name).index('Name-{0000}')
    // ,withChildren(Contact.SObjectType, Contact.AccountId, 5)
    //     .field(Contact.LastName)
    //     .repeat('Adams', 'Johnson')
    //     .field(Contact.FirstName)
    //     .index('Name-{0000}')
    // .save();

    ATK.prepare(Account.SObjectType, 10)
      .field(Account.Name)
      .index('Name-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 2)
      .field(Contact.LastName)
      .repeat('Adams', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance().selectAll()
    );
    List<ID> accountIDList = new List<ID>();
    accountIDList.addAll(theseAccounts.getAccountsMap().keySet());
    Test.startTest();
    AccountProcessor.countContacts(accountIDList);
    Test.stopTest();
  }
}
