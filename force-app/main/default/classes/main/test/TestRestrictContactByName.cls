@isTest
private class TestRestrictContactByName {
  static testMethod void testFail() {
    ATK.prepare(Contact.SObjectType, 10)
      .field(Contact.LastName)
      .repeat('INVALIDNAME', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
  }

  static testMethod void testSuccess() {
    ATK.prepare(Contact.SObjectType, 10)
      .field(Contact.LastName)
      .repeat('Adams', 'Johnson')
      .field(Contact.FirstName)
      .index('Name-{0000}')
      .save();
  }
}
