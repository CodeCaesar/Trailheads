public interface IAssets extends fflib_ISObjects {
  List<Asset> getAssets();
  Map<ID, Asset> getAssetsMap();
  Map<ID, List<Insurance__c>> getAssetsInsurancesMap();
  Map<ID, List<Claim__c>> getAssetsClaimsMap();
}