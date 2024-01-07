public class ContactsSelector extends fflib_SObjectSelector implements IContactsSelector {
  public static IContactsSelector newInstance() {
    return (IContactsSelector) Application.Selector.newInstance(
      Contact.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Contact.Id,
      Contact.AccountID,
      Contact.Name,
      Contact.FirstName,
      Contact.LastName,
      Contact.Phone
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Contact.SObjectType;
  }

  public List<Contact> selectAll() {
    return (List<Contact>) Database.query(newQueryFactory().toSOQL());
  }
}
