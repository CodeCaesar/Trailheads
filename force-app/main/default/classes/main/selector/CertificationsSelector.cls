public class CertificationsSelector extends fflib_SObjectSelector implements ICertificationsSelector {
  public static ICertificationsSelector newInstance() {
    return (ICertificationsSelector) Application.Selector.newInstance(
      Certification__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Certification__c.Id,
      Certification__c.Name,
      Certification__c.Certification_Number__c,
      Certification__c.isActive__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Certification__c.SObjectType;
  }
}
