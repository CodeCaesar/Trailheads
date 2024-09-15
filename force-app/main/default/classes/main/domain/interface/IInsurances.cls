public interface IInsurances {
  Map<Id, Insurance__c> getInsurancesMap();
  List<Insurance__c> getInsurances();
}