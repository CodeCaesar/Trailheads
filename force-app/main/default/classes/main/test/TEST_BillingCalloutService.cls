@IsTest
private class TEST_BillingCalloutService {
    @isTest
    static void testCalloutSuccess() {
        // Set the mock callout
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        // Create a test Accessibility Project
        Accessibility_Project__c theAccessibilityProject = new Accessibility_Project__c(
            Amount__c = 55.0,
            Type__c = 'Sign Language Interpreters',
            Status__c = 'Submitted'
        );
        insert theAccessibilityProject;

        // Call the method to test
        AccessibilityProjectBilling.callBillingService(theAccessibilityProject.Id, theAccessibilityProject.Amount__c);

        // Add assertions to verify the behavior
        // Example: System.assertEquals('ExpectedValue', actualValue);
    }
}