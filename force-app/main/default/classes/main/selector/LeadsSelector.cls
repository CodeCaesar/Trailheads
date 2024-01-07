public class LeadsSelector extends fflib_SObjectSelector implements ILeadsSelector {
  public static ILeadsSelector newInstance() {
    return (ILeadsSelector) Application.Selector.newInstance(Lead.SObjectType);
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Lead.Id,
      Lead.LastName,
      Lead.FirstName,
      Lead.Title,
      Lead.Company,
      Lead.Phone,
      Lead.Email,
      Lead.LeadSource
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Lead.SObjectType;
  }

  public List<Lead> selectAll() {
    return (List<Lead>) Database.query(newQueryFactory().toSOQL());
  }

  public Database.QueryLocator queryLocatorSelectAll() {
    return Database.getQueryLocator(newQueryFactory().toSOQL());
  }
}
