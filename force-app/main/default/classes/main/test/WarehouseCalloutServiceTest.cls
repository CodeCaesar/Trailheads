@IsTest
private class WarehouseCalloutServiceTest {
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
