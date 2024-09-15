global class AccessibilityProjectBilling  implements  Database.AllowsCallouts {
   @future(callout=true)
   public static void callBillingService(String projectId, Decimal billingAmount){
     BillingServiceProxy thisBillingServiceProxy = new BillingServiceProxy();
     BillingServiceProxy.project project = new BillingServiceProxy.project();
     project.username = '{!$Credential.BillingServiceCredential.username}';
     project.password = '{!$Credential.BillingServiceCredential.password}';
     project.projectid = projectId;
     project.billAmount = billingAmount;
     new BillingServiceProxy.InvoicesPortSoap11().billProject(project);
     // String endpoint = '/equipments'; 
     // HttpRequest request = new HttpRequest();
     // request.setEndpoint('callout:IntegrationSB__BillingInvoiceService'+endpoint); 
     // request.setMethod('GET');
     // request.setHeader('projectid', projectId);
     // request.setHeader('billAmount', String.valueOf(billingAmount));
     // request.setHeader('username', '{!$Credential.BillingServiceCredential.username}');
     // request.setHeader('password', '{!$Credential.BillingServiceCredential.password}');
     
            
    }
}