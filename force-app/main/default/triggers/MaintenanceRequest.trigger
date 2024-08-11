trigger MaintenanceRequest on Case(
  after delete,
  after insert,
  after update,
  before delete,
  before insert,
  before update
) {
  fflib_SObjectDomain.triggerHandler(MaintenanceRequestHelper.class);
}
