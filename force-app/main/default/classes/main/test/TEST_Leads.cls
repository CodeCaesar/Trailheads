@IsTest
public class TEST_Leads {
  public static String CRON_EXP = '0 0 0 15 3 ? 2042';
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
  @IsTest
  static void testDailyLeadProcessor() {
    Test.startTest();
    String jobId = System.schedule(
      'DailyLeadProcessor',
      CRON_EXP,
      new DailyLeadProcessor()
    );
    Test.stopTest();
    ILeads theseLeads = Leads.newInstance(
      LeadsSelector.newInstance().selectAll()
    );
    Assert.areEqual(200, theseLeads.getLeads().size());
  }
}
