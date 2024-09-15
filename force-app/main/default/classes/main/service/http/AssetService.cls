@RestResource(urlMapping='/lost/*')
global with sharing class AssetService {
  @HttpPost
  // e.g. https://*.lightning.force.com/services/apexrest/ProductZoning/?ProductCode=GC1020
  global static String reportLostDevice(String assetIdentifier) {
    if (assetIdentifier == null || assetIdentifier.equalsIgnoreCase(''))
      return 'No device found.';

    IAssets theseAssets = Assets.newInstance(
      AssetsSelector.newInstance()
        .selectWithInsurancesAndClaims(new List<String>{ assetIdentifier })
    );

    if (theseAssets.getAssets().size() == 0)
      return 'No device found.';

    List<Insurance__c> flatInsuranceList = new List<Insurance__c>();

    // Iterate through each inner list and add its elements to the flat list
    for (
      List<Insurance__c> innerList : theseAssets.getAssetsInsurancesMap()
        .values()
    ) {
      flatInsuranceList.addAll(innerList);
    }

    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    Boolean updateClaim = false;
    Boolean createClaim = true;
    Set<ID> newClaimsAssetIDSet = new Set<ID>();
    for (Asset thisAsset : theseAssets.getAssets()) {
      if (
        theseAssets.getAssetsInsurancesMap().get(thisAsset.ID) == null ||
        theseAssets.getAssetsInsurancesMap().get(thisAsset.ID).size() == 0
      ) {
        updateClaim = true;
        thisAsset.Status = 'Lost';
        theUnitOfWork.registerDirty(thisAsset);
      } else {
        Boolean foundComprehensiveCoverage = false;
        for (
          Insurance__c thisInsurance : theseAssets.getAssetsInsurancesMap()
            .get(thisAsset.ID)
        ) {
          if (thisInsurance.Coverage__c.equalsIgnoreCase('Comprehensive')) {
            foundComprehensiveCoverage = true;
            newClaimsAssetIDSet.add(thisAsset.ID);
          }
        }
        if (!foundComprehensiveCoverage) {
          updateClaim = true;
          thisAsset.Status = 'Lost';
          theUnitOfWork.registerDirty(thisAsset);
        }
      }
    }

    if (newClaimsAssetIDSet.size() > 0) {
      Asset thisAsset = theseAssets.getAssets()[0];
      thisAsset.Status = 'Lost';
      theUnitOfWork.registerDirty(thisAsset);
      IClaims theseClaims = Claims.newInstance(
        ClaimsSelector.newInstance()
          .selectWithAssetID(theseAssets.getAssetsMap().keySet())
      );
      if (theseClaims.getClaims().size() > 0) {
        theUnitOfWork.commitWork();
        return theseClaims.getClaims()[0].Name + ' already filed';
      } else {
        Claim__c newClaim = new Claim__c();
        newClaim.Contact__c = thisAsset.ContactId;
        newClaim.Type__c = 'Loss';
        newClaim.Asset__C = thisAsset.ID;
        theUnitOfWork.registerNew(newClaim);
        theUnitOfWork.commitWork();
        return ClaimsSelector.newInstance()
            .selectWithAssetID(newClaimsAssetIDSet)[0]
          .Name;
      }
    } else {
      theUnitOfWork.commitWork();
      return 'No coverage. Asset status adjusted to Lost.';
    }
  }
}