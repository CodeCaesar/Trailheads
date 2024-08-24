public interface IAssetsSelector {
  List<Asset> selectAssetIdentifier(List<String> assetsIdentifierList);
  List<Asset> selectWithInsurances(List<String> assetsIdentifierList);
  List<Asset> selectWithInsurancesAndClaims(List<String> assetsIdentifierList);
  List<Asset> selectAll();
  //   List<Asset> selectById(Set<Id> assetIds);
  //   List<Asset> selectAll();
  // Optionally, add more method signatures as needed
}
