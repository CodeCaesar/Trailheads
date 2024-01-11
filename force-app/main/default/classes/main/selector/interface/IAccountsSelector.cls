public interface IAccountsSelector extends fflib_ISObjectSelector {
  List<Account> selectAll();
  List<Account> selectWithContacts(Set<ID> accountIDSet);
  List<Account> selectWithContactsByBillingStateLimit(
    String theBillingState,
    Integer recordLimit
  );
}
