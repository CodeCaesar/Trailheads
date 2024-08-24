public class Assets extends fflib_SObjects implements IAssets {
  public static IAssets newInstance(List<Asset> recordList) {
    return (IAssets) Application.Domain.newInstance(recordList);
  }

  public static IAssets newInstance(Set<Id> recordIdSet) {
    return (IAssets) Application.Domain.newInstance(recordIdSet);
  }

  public Assets(List<Asset> sObjectList) {
    super(sObjectList, Schema.Asset.SObjectType);
  }

  public List<Asset> getAssets() {
    return (List<Asset>) getRecords();
  }

  public Map<ID, Asset> getAssetsMap() {
    return new Map<ID, Asset>(getAssets());
  }

  public Map<ID, List<Insurance__c>> getAssetsInsurancesMap() {
    Map<ID, List<Insurance__c>> assetsInsurancesMap = new Map<ID, List<Insurance__c>>();
    for (Asset thisAsset : getAssets()) {
      for (Insurance__c thisInsurance : thisAsset.Insurances__r) {
        if (assetsInsurancesMap.get(thisAsset.ID) == null) {
          assetsInsurancesMap.put(
            thisAsset.ID,
            new List<Insurance__c>{ thisInsurance }
          );
        } else {
          assetsInsurancesMap.get(thisAsset.ID).add(thisInsurance);
        }
      }
    }
    return assetsInsurancesMap;
  }

  public Map<ID, List<Claim__c>> getAssetsClaimsMap() {
    Map<ID, List<Claim__c>> assetsClaimsMap = new Map<ID, List<Claim__c>>();
    for (Asset thisAsset : getAssets()) {
      for (Claim__c thisClaim : thisAsset.Claims__r) {
        if (assetsClaimsMap.get(thisAsset.ID) == null) {
          assetsClaimsMap.put(thisAsset.ID, new List<Claim__c>{ thisClaim });
        } else {
          assetsClaimsMap.get(thisAsset.ID).add(thisClaim);
        }
      }
    }
    return assetsClaimsMap;
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Assets((List<SObject>) objectList);
    }
  }
}
