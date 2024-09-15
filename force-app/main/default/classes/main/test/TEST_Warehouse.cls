@IsTest
private class TEST_Warehouse {
  @isTest
  static void testSchedulable() {
    String cronExp = '0 0 12 * * ?';
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
    Test.startTest();
    String jobId = System.schedule(
      'WarehouseSyncScheduleJobTest',
      cronExp,
      new WarehouseSyncSchedule()
    );
    Test.stopTest();
    CronTrigger theCronTrigger = [
      SELECT Id, CronExpression, TimesTriggered, NextFireTime
      FROM CronTrigger
      WHERE Id = :jobId
    ];
    System.assertEquals(cronExp, theCronTrigger.CronExpression);
    System.assertEquals(0, theCronTrigger.TimesTriggered);
    System.assertNotEquals(null, theCronTrigger.NextFireTime);
  }
  @isTest
  static void testGetCallout() {
    Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
    Test.startTest();
    System.enqueueJob(new WarehouseCalloutService());
    Test.stopTest();
    Assert.areEqual(
      1,
      [SELECT ID FROM Product2 WHERE Name = 'Cooling Fan'].size()
    );
  }
}