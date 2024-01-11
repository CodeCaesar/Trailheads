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
      Contact.Phone,
      Contact.MailingAddress,
      Contact.MailingStreet,
      Contact.MailingCity,
      Contact.MailingState,
      Contact.MailingPostalCode,
      Contact.MailingCountry,
      Contact.MailingStreet
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Contact.SObjectType;
  }

  public List<Contact> selectAll() {
    return (List<Contact>) Database.query(newQueryFactory().toSOQL());
  }

  public List<Contact> selectByLastNameMailingPostalCode(
    String theLastName,
    String theMailingPostalCode
  ) {
    return (List<Contact>) Database.query(
      newQueryFactory()
        .setCondition('LastName =: theLastName')
        .setCondition('MailingPostalCode =: theMailingPostalCode')
        .toSOQL()
    );
  }
}
