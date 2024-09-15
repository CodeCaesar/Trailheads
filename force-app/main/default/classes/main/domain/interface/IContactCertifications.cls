public interface IContactCertifications extends fflib_ISObjects {
  List<Contact_Certification__c> getContactCertifications();
  Map<ID, Contact_Certification__c> getContactCertificationsMap();
}