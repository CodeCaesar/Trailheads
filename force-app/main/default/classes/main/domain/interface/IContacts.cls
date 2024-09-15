public interface IContacts extends fflib_ISObjects {
  List<Contact> getContacts();
  Map<ID, Contact> getContactsMap();
}