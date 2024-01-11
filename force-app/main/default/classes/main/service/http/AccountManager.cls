@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
  @HttpGet
  global static Account getAccount() {
    RestRequest request = RestContext.request;
    // grab the caseId from the end of the URL
    String accountID = request.requestURI.substringBetween(
      'Accounts/',
      '/contacts'
    );
    Set<ID> accountIDSet = new Set<ID>();
    accountIDSet.add(ID.valueOf(accountID));
    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance().selectWithContacts(accountIDSet)
    );
    return theseAccounts.getAccounts()[0];
  }
}
