public class OpportunitiesSelector extends fflib_SObjectSelector implements IOpportunitiesSelector {
  public static IOpportunitiesSelector newInstance() {
    return (IOpportunitiesSelector) Application.Selector.newInstance(
      Opportunity.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Opportunity.AccountId,
      Opportunity.Amount,
      Opportunity.CloseDate,
      Opportunity.Description,
      Opportunity.ExpectedRevenue,
      Opportunity.Id,
      Opportunity.Name,
      Opportunity.Pricebook2Id,
      Opportunity.Probability,
      Opportunity.StageName,
      Opportunity.Type
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Opportunity.SObjectType;
  }

  public List<Opportunity> selectAll() {
    return (List<Opportunity>) Database.query(newQueryFactory().toSOQL());
  }
}