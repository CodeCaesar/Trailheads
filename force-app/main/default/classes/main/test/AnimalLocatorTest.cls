@isTest
private class AnimalLocatorTest {
  @isTest
  static void testGetCallout() {
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
    String result = AnimalLocator.getAnimalNameById(1);
    Assert.areEqual('chicken', result);
  }
}
