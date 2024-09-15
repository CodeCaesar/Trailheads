public interface IContactCertificationsSelector {
  List<Contact_Certification__c> selectByContactIDAndCertificationID(
    Set<Id> contactIDSet,
    Set<Id> certificationIDSet
  );
  List<Contact_Certification__c> selectByContactNameAndCertificationName(
    List<String> contactNameList,
    List<String> certifcationNameList
  );
  List<Contact_Certification__c> selectAll();
}