public with sharing class ContactSearch {
  public static List<Contact> searchForContacts(
    String theLastName,
    String theMailingPostalCode
  ) {
    IContacts theseContacts = Contacts.newInstance(
      ContactsSelector.newInstance()
        .selectByLastNameMailingPostalCode(theLastName, theMailingPostalCode)
    );
    System.debug(theseContacts.getContacts());
    return theseContacts.getContacts();
  }
}
