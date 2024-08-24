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

  //   @isTest
  //   static void testNoCountryCode() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Regulated zones only', responseString);
  //   }
  //   @isTest
  //   static void testCountryCodeBlank() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', '');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Regulated zones only', responseString);
  //   }

  //   @isTest
  //   static void testCountryCodeAU() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', 'AU');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Authorized zones only', responseString);
  //   }

  //   @isTest
  //   static void testCountryCodeDNE() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC1040');
  //     request.addHeader('CountryCode', 'UK');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Confirm with the local authorities', responseString);
  //   }

  //   @isTest
  //   static void testProductDoesNotExist() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', '12XU');
  //     request.addHeader('CountryCode', 'US');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('ProductCode is missing or doesn\'t exist', responseString);
  //   }
  //   @isTest
  //   static void testProductGeoMappingsDoesNotExist() {
  //     RestRequest request = new RestRequest();
  //     request.requestUri = '/services/apexrest/ProductZoning/';
  //     request.httpMethod = 'GET';
  //     request.addParameter('ProductCode', 'GC8900');
  //     request.addHeader('CountryCode', 'US');
  //     RestContext.request = request;
  //     // Call the method to test
  //     String responseString = ProductZoningService.handleRequest();
  //     System.debug(responseString);
  //     // Verify results
  //     Assert.areEqual('Confirm with the local authorities', responseString);
  //   }
}
