public class LeadProcessor implements Database.Batchable<SObject> {
  public Database.QueryLocator start(Database.BatchableContext ctx) {
    return LeadsSelector.newInstance().queryLocatorSelectAll();
  }

  public void execute(Database.BatchableContext ctx, List<Lead> scope) {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    ILeads theseLeads = Leads.newInstance(scope);
    theseLeads.setFieldValueForAll(theUnitOfWork, 'LeadSource', 'Dreamforce');
    theUnitOfWork.commitWork();
  }

  public void finish(Database.BatchableContext ctx) {
  }
}
