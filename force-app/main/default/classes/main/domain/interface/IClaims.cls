public interface IClaims {
  List<Claim__c> getClaims();
  Map<Id, Claim__c> getClaimsMap();
}
