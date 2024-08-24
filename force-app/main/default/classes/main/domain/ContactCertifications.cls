public class ContactCertifications extends fflib_SObjects implements IContactCertifications {
  public static IContactCertifications newInstance(
    List<Contact_Certification__c> recordList
  ) {
    return (IContactCertifications) Application.Domain.newInstance(recordList);
  }

  public static IContactCertifications newInstance(Set<Id> recordIdSet) {
    return (IContactCertifications) Application.Domain.newInstance(recordIdSet);
  }

  public ContactCertifications(List<Contact_Certification__c> sObjectList) {
    super(sObjectList, Schema.Contact_Certification__c.SObjectType);
  }

  public List<Contact_Certification__c> getContactCertifications() {
    return (List<Contact_Certification__c>) getRecords();
  }

  public Map<ID, Contact_Certification__c> getContactCertificationsMap() {
    return new Map<ID, Contact_Certification__c>(getContactCertifications());
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new ContactCertifications((List<SObject>) objectList);
    }
  }
}
