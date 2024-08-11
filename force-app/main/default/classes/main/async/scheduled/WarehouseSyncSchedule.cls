global with sharing class WarehouseSyncSchedule implements Schedulable {
  global void execute(SchedulableContext sc) {
    WarehouseCalloutService job = new WarehouseCalloutService();
    System.enqueueJob(job);
  }
}
