@IsTest
private class TEST_Certifications {
  @TestSetup
  static void makeData() {
    ATK.SaveResult accountContactResult = ATK.prepare(Account.SObjectType, 5)
      .field(Account.Name)
      .index('Account-{0000}')
      .withChildren(Contact.SObjectType, Contact.AccountId, 5)
      .field(Contact.FirstName)
      .index('First-{0000}')
      .field(Contact.LastName)
      .index('Last-{0000}')
      .save();

    List<Id> accountIds = new List<Id>();
    List<Id> contactIds = new List<Id>();
    for (
      Contact con : (List<Contact>) accountContactResult.get(
        Contact.SObjectType,
        0
      )
    ) {
      contactIds.add(con.Id);
    }

    ATK.SaveResult certificationResult = ATK.prepare(
        Certification__c.SObjectType,
        5
      )
      .field(Certification__c.Name)
      .index('Certification-{0000}')
      .save();

    List<Id> certificationIds = new List<Id>();
    for (
      Certification__c cert : (List<Certification__c>) certificationResult.get(
        Certification__c.SObjectType,
        0
      )
    ) {
      certificationIds.add(cert.Id);
    }

    ATK.SaveResult contactCertificationResult = ATK.prepare(
        Contact_Certification__c.SObjectType,
        10
      )
      .field(Contact_Certification__c.Contact__c)
      .repeat(contactIds)
      .field(Contact_Certification__c.Certification__c)
      .repeat(certificationIds)
      .field(Contact_Certification__c.isActive__c)
      .repeat(true, false)
      .field(Contact_Certification__c.Issue_Date__c)
      .repeat(Date.today())
      .save();
  }

  @isTest
  static void testBadContactName() {
    String result = CredentialVerificationService.verifyCredential(
      'bad',
      [SELECT ID, Name FROM Contact_Certification__c LIMIT 1][0].Name
    );
    Assert.areEqual('No record found', result);
  }

  @isTest
  static void testBadCertificationName() {
    String result = CredentialVerificationService.verifyCredential(
      [SELECT ID, LastName FROM Contact LIMIT 1][0].LastName,
      'Bad'
    );
    Assert.areEqual('No record found', result);
  }

  @isTest
  static void testActiveCertification() {
    IContacts theseContacts = Contacts.newInstance(
      ContactsSelector.newInstance().selectAll()
    );
    IContactCertifications theseContactCertifications = ContactCertifications.newInstance(
      ContactCertificationsSelector.newInstance().selectAll()
    );

    String result = CredentialVerificationService.verifyCredential(
      theseContacts.getContactsMap()
        .get(
          theseContactCertifications.getContactCertifications()[0].Contact__c
        )
        .LastName,
      theseContactCertifications.getContactCertifications()[0].Name
    );
    Assert.areEqual('Valid', result);
  }

  @isTest
  static void testInActiveCertification() {
    IContacts theseContacts = Contacts.newInstance(
      ContactsSelector.newInstance().selectAll()
    );
    IContactCertifications theseContactCertifications = ContactCertifications.newInstance(
      ContactCertificationsSelector.newInstance().selectAll()
    );

    String result = CredentialVerificationService.verifyCredential(
      theseContacts.getContactsMap()
        .get(
          theseContactCertifications.getContactCertifications()[1].Contact__c
        )
        .LastName,
      theseContactCertifications.getContactCertifications()[1].Name
    );
    Assert.areEqual('Needs Renewal', result);
  }
}