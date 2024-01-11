@isTest
private class ParkLocatorTest {
  @isTest
  static void testCallout() {
    // This causes a fake response to be generated
    Test.setMock(WebServiceMock.class, new ParkServiceMock());
    // Call the method that invokes a callout
    List<String> resultList = ParkLocator.country('Germany');
    // Verify that a fake result is returned
    Assert.areEqual('Hamburg Wadden Sea National Park', resultList[0]);
    Assert.areEqual('Hainich National Park', resultList[1]);
    Assert.areEqual('Bavarian Forest National Park', resultList[2]);
  }
}
