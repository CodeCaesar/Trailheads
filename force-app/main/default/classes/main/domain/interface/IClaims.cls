public interface IClaims {
  List<Claim__c> getClaims();
  Map<Id, Claim__c> getClaimsMap();
  Map<ID, List<Claim__c>> getAssetsClaimsMap();
}