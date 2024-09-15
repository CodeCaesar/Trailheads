public class Insurances extends fflib_SObjects implements IInsurances {
  // Static method to create a new instance with a list of Insurance__c records
  public static IInsurances newInstance(List<Insurance__c> recordList) {
    return (IInsurances) Application.Domain.newInstance(recordList);
  }

  // Static method to create a new instance with a set of Insurance__c record IDs
  public static IInsurances newInstance(Set<Id> recordIdSet) {
    return (IInsurances) Application.Domain.newInstance(recordIdSet);
  }

  // Constructor that accepts a list of Insurance__c records
  public Insurances(List<Insurance__c> sObjectList) {
    super(sObjectList, Schema.Insurance__c.SObjectType);
  }

  // Method to get the list of Insurance__c records
  public List<Insurance__c> getInsurances() {
    return (List<Insurance__c>) getRecords();
  }

  // Method to get a map of Insurance__c records by their IDs
  public Map<Id, Insurance__c> getInsurancesMap() {
    return new Map<Id, Insurance__c>(getInsurances());
  }

  // Inner class to construct Insurances instances
  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Insurances((List<SObject>) objectList);
    }
  }
}