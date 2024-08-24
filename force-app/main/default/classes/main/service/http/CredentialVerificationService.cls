global class CredentialVerificationService {
  webService static String verifyCredential(
    String lastName,
    String certificationName
  ) {
    List<String> lastNameList = new List<String>{ lastName };
    List<String> certificationNameList = new List<String>{ certificationName };
    IContactCertifications theseContactCertifications = ContactCertifications.newInstance(
      ContactCertificationsSelector.newInstance()
        .selectByContactNameAndCertificationName(
          lastNameList,
          certificationNameList
        )
    );
    System.debug(theseContactCertifications.getContactCertifications());
    //System.debug(theseContactCertifications.getContactCertifications());
    System.debug(theseContactCertifications.getContactCertifications());
    if (
      theseContactCertifications.getContactCertifications() == null ||
      theseContactCertifications.getContactCertifications().size() == 0
    ) {
      return 'No record found';
    } else if (
      theseContactCertifications.getContactCertifications()[0].isActive__c ==
      false
    ) {
      return 'Needs Renewal';
    } else {
      return 'Valid';
    }
  }
}
