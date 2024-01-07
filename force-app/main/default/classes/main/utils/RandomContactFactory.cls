public class RandomContactFactory {
  public static List<Contact> generateRandomContacts(
    Integer numberOfContacts,
    String LastName
  ) {
    List<Contact> contactList = new List<Contact>();
    ATK.SaveResult result = ATK.prepare(Contact.SObjectType, numberOfContacts)
      .field(Contact.LastName)
      .repeat(LastName)
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
    contactList = result.get(Contact.SObjectType);
    return contactList;
  }
}
