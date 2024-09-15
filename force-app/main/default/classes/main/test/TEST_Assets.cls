@IsTest
private class TEST_Assets {
  @TestSetup
  static void makeData() {
    ATK.SaveResult accountContactResult = ATK.prepare(Account.SObjectType, 5)
      .field(Account.Name)
      .index('XYZ-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 5)
      .field(Contact.LastName)
      .index('XYZ-{0000}')
      .field(Contact.Email)
      .index('test.user+{0000}@iqubecd92hbf23.com')
      .save();

    List<Id> accountIds = new List<Id>();
    List<Id> contactIds = new List<Id>();
    Map<ID, Account> accountMap = new Map<ID, Account>(
      (List<Account>) accountContactResult.get(Account.SObjectType, 0)
    );
    Map<ID, Contact> contactMap = new Map<ID, Contact>(
      (List<Contact>) accountContactResult.get(Contact.SObjectType, 0)
    );
    accountIds.addAll(accountMap.keySet());
    contactIds.addAll(contactMap.keySet());

    ATK.SaveResult assetInsuranceResult = ATK.prepare(Asset.SObjectType, 5)
      .field(Asset.Name)
      .index('Asset-{0000}')
      .field(Asset.AccountId)
      .repeat(accountIds)
      .field(Asset.ContactId)
      .repeat(contactIds)
      .field(Asset.Asset_Identifier__c)
      .index('AssetIdentifier-{0000}')
      .withChildren(Insurance__c.SObjectType, Insurance__c.Asset__c, 5)
      .field(Insurance__c.Name)
      .index('Insurance-{0000}')
      .field(Insurance__c.Active__c)
      .repeat(true, true, true, true, false)
      .field(Insurance__c.Start_Date__c)
      .repeat(Date.newInstance(2024, 11, 11))
      .field(Insurance__c.End_Date__c)
      .repeat(Date.newInstance(2025, 11, 11))
      .field(Insurance__c.Coverage__c)
      .repeat('Comprehensive', 'Liability', 'Flyaway', 'Equipment')
      .save();

    ATK.SaveResult noInsuranceResult = ATK.prepare(Asset.SObjectType, 1)
      .field(Asset.Name)
      .index('Asset-{1000}')
      .field(Asset.AccountId)
      .repeat(accountIds)
      .field(Asset.ContactId)
      .repeat(contactIds)
      .field(Asset.Asset_Identifier__c)
      .index('AssetIdentifier-{1000}')
      .save();

    System.debug(noInsuranceResult.get(Asset.SObjectType, 0)[0]);
    List<Id> assetIds = new List<Id>();
    List<Id> insuranceIds = new List<Id>();
    Map<ID, Asset> assetMap = new Map<ID, Asset>(
      (List<Asset>) assetInsuranceResult.get(Asset.SObjectType, 0)
    );
    Map<ID, Insurance__c> insuranceMap = new Map<ID, Insurance__c>(
      (List<Insurance__c>) assetInsuranceResult.get(Insurance__c.SObjectType, 0)
    );
    assetIds.addAll(assetMap.keySet());
    insuranceIds.addAll(insuranceMap.keySet());

    ATK.SaveResult claimResult = ATK.prepare(Claim__c.SObjectType, 4)
      .field(Claim__c.Name)
      .index('Claim-{0000}')
      .field(Claim__c.Contact__c)
      .repeat(contactIds)
      .field(Claim__c.Type__c)
      .repeat('Liability', 'Damage', 'Loss', 'Equipment', 'Injury')
      .field(Claim__c.Insurance__c)
      .repeat(insuranceIds)
      .field(Claim__c.Asset__c)
      .repeat(assetIds)
      .save();
  }

  /*Invalid Asset Identifier: Test with scenarios where the assetIdentifier is either missing or does not exist in the system. The API should handle these cases and return No device found. in the response.*/
  @isTest
  static void testNullAssetIdentifier() {
    String resultString = AssetService.reportLostDevice(null);
    Assert.areEqual('No device found.', resultString);
  }

  @isTest
  static void testEmptyStringAssetIdentifier() {
    String resultString = AssetService.reportLostDevice('');
    Assert.areEqual('No device found.', resultString);
  }

  @isTest
  static void tesAssetIdentifierDNE() {
    String resultString = AssetService.reportLostDevice('oeubofeub');
    Assert.areEqual('No device found.', resultString);
  }

  //   Claim Number: Test with an asset record which has an active comprehensive insurance coverage,
  // and returns the claim number (API Name Claim__c.Name).
  @isTest
  static void testComprehensiveCoverage() {
    String resultString = AssetService.reportLostDevice('AssetIdentifier-0005');
    Assert.areEqual('C0100000', resultString);
  }

  @isTest
  static void testClaimTypeLostExists() {
    String resultString = AssetService.reportLostDevice('AssetIdentifier-0001');
    Assert.areEqual('C0100000 already filed', resultString);
  }

  @isTest
  static void testNoInsurance() {
    String resultString = AssetService.reportLostDevice(
      'AssetIdentifier-{1000}'
    );
    Assert.areEqual(
      'No coverage. Asset status adjusted to Lost.',
      resultString
    );
  }
}