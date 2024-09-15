@IsTest
private class TEST_WellnessJourneys {
  @TestSetup
  static void makeData() {

    ATK.SaveResult userResults = ATK.prepare(User.SObjectType, 5)
                                          .field(User.FirstName)
                                          .index('FirstName-{0000}')
                                          .field(User.LastName)
                                          .repeat('Smith', 'Johnson')
                                          .field(User.Email)
                                          .index('user{0000}@example.com')
                                          .field(User.Username)
                                          .index('user{0000}@example.com')
                                          .field(User.Alias)
                                          .index('user{0000}')
                                          .field(User.TimeZoneSidKey).repeat('Pacific/Auckland')
                                          .field(User.LocaleSidKey)
                                          .repeat('en_US')
                                          .field(User.EmailEncodingKey)
                                          .repeat('UTF-8')
                                          .profile('Standard Platform User')
                                          .field(User.LanguageLocaleKey)
                                          .repeat('en_US')
                                          .save();

    List<User> testUsers = (List<User>) userResults.get(User.SObjectType,0);
    
    Map<Integer, Object> userIdMap = CSUtils.extractUserIds(testUsers);

    for (Integer i = 0; i < 3; i++) {
        ATK.prepare(Wellness_Journey__c.SObjectType, 50)
            .field(Wellness_Journey__c.OwnerId)
            .repeat(userIdMap.get(i))
            .field(Wellness_Journey__c.Status__c)
            .repeat('Complete', 'In Progress')
            .field(Wellness_Journey__c.Completion_Date__c)
            .repeat(CSUtils.getEndDate().addDays(-i))
            .save();
    }

    for (Integer i = 3; i < 5; i++) {
        ATK.prepare(Wellness_Journey__c.SObjectType, 10)
            .field(Wellness_Journey__c.OwnerId)
            .repeat(userIdMap.get(i))
            .field(Wellness_Journey__c.Status__c)
            .repeat('Complete', 'In Progress')
            .field(Wellness_Journey__c.Completion_Date__c)
            .repeat(CSUtils.getEndDate().addDays(-i))
            .save();
    }
  }
  @isTest
  static void testBatchExecution() {
    Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
      Test.startTest();
        WellnessJourneyRewardsBatch batch = new WellnessJourneyRewardsBatch();
        Database.executeBatch(batch);
      Test.stopTest();
  }
}