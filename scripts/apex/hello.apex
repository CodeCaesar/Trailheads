ATK.SaveResult accountContactResult = ATK.prepare(Account.SObjectType, 5)
  .field(Account.Name)
  .index('Account-{0000}')
  .withChildren(Contact.SObjectType, Contact.AccountId, 5)
  .field(Contact.LastName)
  .index('LastName-{0000}')
  .field(Contact.Email)
  .index('test.user+{0000}@email.com')
  .field(Contact.MobilePhone)
  .index('+86 186 7777 {0000}')
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
  .repeat(true)
  .field(Insurance__c.Start_Date__c)
  .repeat(Date.newInstance(2024, 11, 11))
  .field(Insurance__c.End_Date__c)
  .repeat(Date.newInstance(2025, 11, 11))
  .field(Insurance__c.Coverage__c)
  .repeat('Comprehensive')
  .save();

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

ATK.SaveResult claimResult = ATK.prepare(Claim__c.SObjectType, 5)
  .field(Claim__c.Name)
  .index('Claim-{0000}')
  .field(Claim__c.Contact__c)
  .repeat(contactIds)
  .field(Claim__c.Type__c)
  .repeat('Damage')
  .field(Claim__c.Insurance__c)
  .repeat(insuranceIds)
  .field(Claim__c.Asset__c)
  .repeat(assetIds)
  .save();

// Delete Claims
List<Claim__c> claimsToDelete = [
  SELECT Id
  FROM Claim__c
  WHERE Name LIKE 'Claim-%'
];
delete claimsToDelete;

// Delete Insurances
List<Insurance__c> insurancesToDelete = [
  SELECT Id
  FROM Insurance__c
  WHERE Name LIKE 'Insurance-%'
];
delete insurancesToDelete;

// Delete Assets
List<Asset> assetsToDelete = [SELECT Id FROM Asset WHERE Name LIKE 'Asset-%'];
delete assetsToDelete;

// Delete Contacts
List<Contact> contactsToDelete = [
  SELECT Id
  FROM Contact
  WHERE LastName LIKE 'LastName-%'
];
delete contactsToDelete;

// Delete Accounts
List<Account> accountsToDelete = [
  SELECT Id
  FROM Account
  WHERE Name LIKE 'Account-%'
];
delete accountsToDelete;

IAssets theseAssets = Assets.newInstance(
  AssetsSelector.newInstance()
    .selectWithInsurancesAndClaims(new List<String>{ '6543210' })
);

System.debug(theseAssets.getAssetsClaimsMap());
