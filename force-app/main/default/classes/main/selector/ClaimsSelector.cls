public class ClaimsSelector extends fflib_SObjectSelector implements IClaimsSelector {
  public static IClaimsSelector newInstance() {
    return (IClaimsSelector) Application.Selector.newInstance(
      Claim__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Claim__c.Id,
      Claim__c.Name,
      Claim__c.Asset__c,
      Claim__c.Contact__c,
      Claim__c.Description__c,
      Claim__c.Insurance__c,
      Claim__c.Status__c,
      Claim__c.Type__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Claim__c.SObjectType;
  }

  public List<Claim__c> selectByNameWithComprehensiveInsurance(
    List<String> claimNamesList
  ) {
    return Database.query(
      newQueryFactory()
        .selectField('Insurance__r.Coverage__c')
        .setCondition('Name in :claimNamesList')
        .setCondition('Insurance__r.Coverage__c = \'Comprehensive\'')
        .toSOQL()
    );
  }

  public List<Claim__c> selectByAssetsWithInsuranceCoverage(
    List<String> assetIdsList
  ) {
    return Database.query(
      newQueryFactory()
        .selectField('Insurance__r.Coverage__c')
        .setCondition('Asset__c IN :assetIdsList')
        .setCondition('Insurance__r.Coverage__c = \'Comprehensive\'')
        .toSOQL()
    );
  }

  public List<Claim__c> selectWithInsuranceCoverage(List<String> assetIdsList) {
    return Database.query(
      newQueryFactory()
        .selectField('Insurance__r.Coverage__c')
        .setCondition('Asset__c IN :assetIdsList')
        .toSOQL()
    );
  }

  public List<Claim__c> selectAll() {
    return (List<Claim__c>) Database.query(newQueryFactory().toSOQL());
  }

  public List<Claim__c> selectWithAssetID(Set<ID> assetIdsSet) {
    return Database.query(
      newQueryFactory().setCondition('Asset__c IN :assetIdsSet').toSOQL()
    );
  }
}