public interface IClaimsSelector {
  List<Claim__c> selectByNameWithComprehensiveInsurance(
    List<String> claimNamesList
  );
  List<Claim__c> selectByAssetsWithInsuranceCoverage(List<String> assetIdsList);
  List<Claim__c> selectWithInsuranceCoverage(List<String> assetIdsList);
  List<Claim__c> selectAll();
  List<Claim__c> selectWithAssetID(Set<ID> assetIdsSet);
}