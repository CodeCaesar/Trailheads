public class CasesSelector extends fflib_SObjectSelector implements ICasesSelector {
  public static ICasesSelector newInstance() {
    return (ICasesSelector) Application.Selector.newInstance(Case.SObjectType);
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Case.Id,
      Case.AccountId,
      Case.CaseNumber,
      Case.Description,
      Case.Origin,
      Case.Reason,
      Case.ContactId,
      Case.Date_Due__c,
      Case.Date_Reported__c,
      Case.EngineeringReqNumber__c,
      Case.Priority,
      Case.Product__c,
      Case.ProductId,
      Case.SLAViolation__c,
      Case.Vehicle__c,
      Case.Status,
      Case.Type,
      Case.IsClosed
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Case.SObjectType;
  }

  public List<Case> selectAll() {
    return (List<Case>) Database.query(newQueryFactory().toSOQL());
  }

  public List<Case> selectWithMaintenanceRequestsAndProducts(
    Set<ID> caseIDSet
  ) {
    EquipmentMaintenanceItemsSelector theEquipmentMaintenanceItemsSelector = new EquipmentMaintenanceItemsSelector();
    fflib_QueryFactory caseQueryFactory = newQueryFactory();
    theEquipmentMaintenanceItemsSelector.addQueryFactorySubselect(
      caseQueryFactory
    );
    caseQueryFactory.setCondition('Id in: caseIDSet');

    return (List<Case>) Database.query(caseQueryFactory.toSOQL());
  }

  public Database.QueryLocator queryLocatorSelectAll() {
    return Database.getQueryLocator(newQueryFactory().toSOQL());
  }
}
