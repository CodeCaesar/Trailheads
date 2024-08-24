public class Claims extends fflib_SObjects implements IClaims {
  public static IClaims newInstance(List<Claim__c> recordList) {
    return (IClaims) Application.Domain.newInstance(recordList);
  }

  public static IClaims newInstance(Set<Id> recordIdSet) {
    return (IClaims) Application.Domain.newInstance(recordIdSet);
  }

  public Claims(List<Claim__c> sObjectList) {
    super(sObjectList, Schema.Claim__c.SObjectType);
  }

  public List<Claim__c> getClaims() {
    return (List<Claim__c>) getRecords();
  }

  public Map<Id, Claim__c> getClaimsMap() {
    return new Map<Id, Claim__c>(getClaims());
  }

  public Map<ID, List<Claim__c>> getAssetsClaimsMap() {
    Map<ID, List<Claim__c>> assetsClaimsMap = new Map<ID, List<Claim__c>>();
    for (Claim__c thisClaim : getClaims()) {
      if (assetsClaimsMap.get(thisClaim.Asset__c) == null) {
        assetsClaimsMap.put(
          thisClaim.Asset__c,
          new List<Claim__c>{ thisClaim }
        );
      } else {
        assetsClaimsMap.get(thisClaim.Asset__c).add(thisClaim);
      }
    }
    return assetsClaimsMap;
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Claims((List<SObject>) objectList);
    }
  }
}
