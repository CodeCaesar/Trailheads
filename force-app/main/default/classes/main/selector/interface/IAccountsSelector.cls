public interface IAccountsSelector extends fflib_ISObjectSelector {
  List<Account> selectAll();
  List<Account> selectWithContacts(Set<ID> accountIDSet);
}
