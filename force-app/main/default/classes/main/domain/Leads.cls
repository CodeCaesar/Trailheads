public class Leads extends fflib_SObjects implements ILeads {
  public static ILeads newInstance(List<Lead> recordList) {
    return (ILeads) Application.Domain.newInstance(recordList);
  }

  public static ILeads newInstance(Set<Id> recordIdSet) {
    return (ILeads) Application.Domain.newInstance(recordIdSet);
  }

  public Leads(List<Lead> sObjectList) {
    super(sObjectList, Schema.Lead.SObjectType);
  }

  public List<Lead> getLeads() {
    return (List<Lead>) getRecords();
  }

  public Map<ID, Lead> getLeadsMap() {
    return new Map<ID, Lead>(getLeads());
  }

  public void setFieldValueForAll(
    fflib_ISObjectUnitOfWork theUnitOfWork,
    String apiString,
    String valueString
  ) {
    for (Lead thisLead : getLeads()) {
      thisLead.put(apiString, valueString);
      theUnitOfWork.registerDirty(thisLead);
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Leads((List<SObject>) objectList);
    }
  }
}
