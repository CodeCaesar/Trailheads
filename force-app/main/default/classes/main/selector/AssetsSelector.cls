public class AssetsSelector extends fflib_SObjectSelector implements IAssetsSelector {
  public static IAssetsSelector newInstance() {
    return (IAssetsSelector) Application.Selector.newInstance(
      Asset.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Asset.Id,
      Asset.Name,
      Asset.AccountId,
      Asset.ContactId,
      Asset.Product2Id,
      Asset.Quantity,
      Asset.Status,
      Asset.InstallDate,
      Asset.UsageEndDate,
      Asset.CreatedDate,
      Asset.LastModifiedDate
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Asset.SObjectType;
  }

  public List<Asset> selectAssetIdentifier(List<String> assetsIdentifierList) {
    return Database.query(
      newQueryFactory()
        .setCondition('Asset_Identifier__c in :assetsIdentifierList')
        .toSOQL()
    );
  }

  public List<Asset> selectAll() {
    return (List<Asset>) Database.query(newQueryFactory().toSOQL());
  }

  public List<Asset> selectWithInsurances(List<String> assetsIdentifierList) {
    InsurancesSelector insurancesSelector = new InsurancesSelector();
    fflib_QueryFactory assetQueryFactory = newQueryFactory();
    assetQueryFactory.setCondition(
      'Asset_Identifier__c in :assetsIdentifierList'
    );
    insurancesSelector.addQueryFactorySubselect(assetQueryFactory);
    return Database.query(assetQueryFactory.toSOQL());
  }

  public List<Asset> selectWithInsurancesAndClaims(
    List<String> assetsIdentifierList
  ) {
    InsurancesSelector insurancesSelector = new InsurancesSelector();
    ClaimsSelector thisClaimsSelector = new ClaimsSelector();
    fflib_QueryFactory assetQueryFactory = newQueryFactory();
    assetQueryFactory.setCondition(
      'Asset_Identifier__c in :assetsIdentifierList'
    );
    insurancesSelector.addQueryFactorySubselect(assetQueryFactory);
    thisClaimsSelector.addQueryFactorySubselect(assetQueryFactory);
    System.debug(assetQueryFactory.toSOQL());
    return Database.query(assetQueryFactory.toSOQL());
  }
}
