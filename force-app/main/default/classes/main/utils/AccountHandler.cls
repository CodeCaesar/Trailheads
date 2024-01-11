public with sharing class AccountHandler {
  public static Account insertNewAccount(String accountName) {
    try {
      Account thisAccount = new Account();
      thisAccount.Name = accountName;
      insert thisAccount;
      return thisAccount;
    } catch (Exception exe) {
      return null;
    }
  }
}
