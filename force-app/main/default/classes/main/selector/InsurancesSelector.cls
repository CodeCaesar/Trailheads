public class InsurancesSelector extends fflib_SObjectSelector implements IInsurancesSelector {
  public static IInsurancesSelector newInstance() {
    return (IInsurancesSelector) Application.Selector.newInstance(
      Insurance__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Insurance__c.Id,
      Insurance__c.Name,
      Insurance__c.Active__c,
      Insurance__c.Asset__c,
      Insurance__c.Coverage__c,
      Insurance__c.End_Date__c,
      Insurance__c.Start_Date__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Insurance__c.SObjectType;
  }
}
