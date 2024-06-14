public interface IClaimsSelector {
  List<Claim__c> selectByNameWithComprehensiveInsurance(
    List<String> claimNamesList
  );
  List<Claim__c> selectByAssetsWithInsuranceCoverage(List<String> assetIdsList);
}
