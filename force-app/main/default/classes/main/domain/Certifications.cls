public class Certifications extends fflib_SObjects implements ICertifications {
  public static ICertifications newInstance(List<Certification__c> recordList) {
    return (ICertifications) Application.Domain.newInstance(recordList);
  }

  public static ICertifications newInstance(Set<Id> recordIdSet) {
    return (ICertifications) Application.Domain.newInstance(recordIdSet);
  }

  public Certifications(List<Certification__c> sObjectList) {
    super(sObjectList, Schema.Certification__c.SObjectType);
  }

  public List<Certification__c> getCertifications() {
    return (List<Certification__c>) getRecords();
  }

  public Map<ID, Certification__c> getCertificationsMap() {
    return new Map<ID, Certification__c>(getCertifications());
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Certifications((List<SObject>) objectList);
    }
  }
}
