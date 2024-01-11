public interface IContactsSelector extends fflib_ISObjectSelector {
  List<Contact> selectAll();
  List<Contact> selectByLastNameMailingPostalCode(
    String theLastName,
    String theMailingPostalCode
  );
}
