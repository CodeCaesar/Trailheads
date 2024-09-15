public class ContactCertificationsSelector extends fflib_SObjectSelector implements IContactCertificationsSelector {
  public static IContactCertificationsSelector newInstance() {
    return (IContactCertificationsSelector) Application.Selector.newInstance(
      Contact_Certification__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Contact_Certification__c.Id,
      Contact_Certification__c.Name,
      Contact_Certification__c.Certification__c,
      Contact_Certification__c.Contact__c,
      Contact_Certification__c.isActive__c,
      Contact_Certification__c.Issue_Date__c
    };
  }
  public Schema.SObjectType getSObjectType() {
    return Contact_Certification__c.SObjectType;
  }

  public List<Contact_Certification__c> selectByContactIDAndCertificationID(
    Set<Id> contactIDSet,
    Set<Id> certificationIDSet
  ) {
    fflib_QueryFactory contactCertificationQueryFactory = newQueryFactory();
    contactCertificationQueryFactory.setCondition(
      'Contact__c IN :contactIDSet AND Certification__c IN :certificationIDSet'
    );
    return Database.query(contactCertificationQueryFactory.toSOQL());
  }
  public List<Contact_Certification__c> selectByContactNameAndCertificationName(
    List<String> contactNameList,
    List<String> certifcationNameList
  ) {
    return Database.query(
      newQueryFactory()
        .selectField('Contact__r.LastName')
        .selectField('Certification__r.Name')
        .setCondition(
          'Contact__r.LastName IN :contactNameList AND Name IN :certifcationNameList'
        )
        .toSOQL()
    );
  }

  public List<Contact_Certification__c> selectAll() {
    return (List<Contact_Certification__c>) Database.query(
      newQueryFactory().toSOQL()
    );
  }
}