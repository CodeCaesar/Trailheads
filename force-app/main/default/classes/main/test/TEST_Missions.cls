@IsTest
private class TEST_Missions implements Database.RaisesPlatformEvents {
  @TestSetup
  static void makeData() {
    ATK.SaveResult pilotContactResult = ATK.prepare(Contact.SObjectType, 5)
      .field(Contact.FirstName)
      .index('FirstName-{0000}')
      .field(Contact.LastName)
      .index('LastName-{0000}')
      .withChildren(Mission__c.SObjectType, Mission__c.Pilot__c, 5)
      .field(Mission__c.Completion_Rating__c)
      .repeat(4.5)
      .field(Mission__c.Overall_Rating__c)
      .repeat(3.2)
      .field(Mission__c.Safety_Incidents__c)
      .repeat(2)
      .field(Mission__c.Subject__c)
      .index('Subject-{0000}')
      .save();
    ATK.SaveResult pilotlessMissionResult = ATK.prepare(
        Mission__c.SObjectType,
        5
      )
      .field(Mission__c.Completion_Rating__c)
      .repeat(4.5)
      .field(Mission__c.Overall_Rating__c)
      .repeat(3.2)
      .field(Mission__c.Safety_Incidents__c)
      .repeat(2)
      .field(Mission__c.Subject__c)
      .index('Subject-{0000}')
      .save();
  }

  @IsTest
  static void testPublishBatchApexErrorEvent() {
    // Start the batch
    Test.startTest();
    PilotRatingBatch batch = new PilotRatingBatch();
    Database.executeBatch(batch);
    Test.stopTest();
  }
}