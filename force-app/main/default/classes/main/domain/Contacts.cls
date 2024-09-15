public class Contacts extends fflib_SObjects implements IContacts {
  public static IContacts newInstance(List<Contact> recordList) {
    return (IContacts) Application.Domain.newInstance(recordList);
  }

  public static IContacts newInstance(Set<Id> recordIdSet) {
    return (IContacts) Application.Domain.newInstance(recordIdSet);
  }

  public Contacts(List<Contact> sObjectList) {
    super(sObjectList, Schema.Contact.SObjectType);
  }

  public List<Contact> getContacts() {
    return (List<Contact>) getRecords();
  }

  public Map<ID, Contact> getContactsMap() {
    return new Map<ID, Contact>(getContacts());
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Contacts((List<SObject>) objectList);
    }
  }
}