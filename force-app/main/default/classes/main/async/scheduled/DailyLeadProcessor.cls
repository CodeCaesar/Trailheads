global with sharing class DailyLeadProcessor implements Schedulable {
  global void execute(SchedulableContext sc) {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    ILeads theseLeads = Leads.newInstance(
      LeadsSelector.newInstance().selectAll()
    );
    theseLeads.setFieldValueForAll(theUnitOfWork, 'LeadSource', 'Dreamforce');
    theUnitOfWork.commitWork();
  }
}
