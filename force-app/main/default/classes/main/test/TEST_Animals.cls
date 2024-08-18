@isTest
private class TEST_Animals {
  static testMethod void testParse() {
    String json = '{\"animal\":{\"id\":2,\"name\":\"bear\",\"eats\":\"berries, campers, adam seligman\",\"says\":\"yum yum\"}}';
    Animals obj = Animals.parse(json);
    System.assert(obj != null);
  }

  @isTest
  static void testGetCallout() {
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
    String result = AnimalLocator.getAnimalNameById(1);
    Assert.areEqual('chicken', result);
  }
}
