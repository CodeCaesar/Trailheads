@IsTest
public class LeadProcessorTest {
  @TestSetup
  static void makeData() {
    ATK.prepare(Lead.SObjectType, 200)
      .field(Lead.LastName)
      .index('Name-{0000}')
      .field(Lead.Company)
      .index('Name-{0000}')
      .save();
  }

  @IsTest
  static void testBatchLead() {
    Test.startTest();
    LeadProcessor thisLeadProcessor = new LeadProcessor();
    ID batchId = Database.executeBatch(thisLeadProcessor);
    Test.stopTest();
  }
}
