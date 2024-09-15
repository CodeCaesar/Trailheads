public class Application {
  // Configure and create the UnitOfWorkFactory for this Application
  public static final fflib_Application.UnitOfWorkFactory UnitOfWork = new fflib_Application.UnitOfWorkFactory(
    new List<SObjectType>{
      Lead.SObjectType,
      Account.SObjectType,
      Contact.SObjectType,
      Opportunity.SObjectType,
      Product2.SObjectType,
      Case.SObjectType,
      Asset.SObjectType,
      Insurance__c.SObjectType,
      Claim__c.SObjectType,
      Certification__C.SObjectType,
      Contact_Certification__c.SObjectType,
      Equipment_Maintenance_Item__c.SObjectType,
      Mission__c.SObjectType,
      PricebookEntry.SObjectType,
      Order.SObjectType,
      OrderItem.SObjectType,
      OpportunityLineItem.SObjectType,
      Wellness_Journey__c.SObjectType,
      Error_Log__c.SObjectType,
      Accessibility_Project__c.SObjectType,
      Task.SObjectType,
      Order_Event__e.SObjectType,
      BatchApexErrorEvent.SObjectType
    }
  );

  //   // Configure and create the ServiceFactory for this Application
  //   public static final fflib_Application.ServiceFactory Service = new fflib_Application.ServiceFactory(
  //     new Map<Type, Type>{
  //       IAccountsService.class => AccountsServiceImpl.class,
  //       IOpportunitiesService.class => OpportunitiesServiceImpl.class,
  //       IInvoicingService.class => InvoicingServiceImpl.class
  //     }
  //   );

  // Configure and create the SelectorFactory for this Application
  public static final fflib_Application.SelectorFactory Selector = new fflib_Application.SelectorFactory(
    new Map<SObjectType, Type>{
      Account.SObjectType => AccountsSelector.class,
      Contact.SObjectType => ContactsSelector.class,
      Opportunity.SObjectType => OpportunitiesSelector.class,
      Lead.SObjectType => LeadsSelector.class,
      Case.SObjectType => CasesSelector.class,
      Product2.SObjectType => ProductsSelector.class,
      PricebookEntry.SObjectType => PricebookEntriesSelector.class,
      Order.SObjectType => OrdersSelector.class,
      OrderItem.SObjectType => OrderitemsSelector.class,
      Asset.SObjectType => AssetsSelector.class,
      Insurance__c.SObjectType => InsurancesSelector.class,
      Claim__c.SObjectType => ClaimsSelector.class,
      Certification__C.SObjectType => ContactCertifications.class,
      Contact_Certification__c.SObjectType => ContactCertificationsSelector.class,
      Equipment_Maintenance_Item__c.SObjectType => EquipmentMaintenanceItemsSelector.class,
      Wellness_Journey__c.SObjectType => WellnessJourneysSelector.class,
      Accessibility_Project__c.SObjectType => AccessibilityProjectsSelector.class,
      Product_Geo_Mapping__mdt.SObjectType => ProductGeoMappingSelector.class
    }
  );

  // Configure and create the DomainFactory for this Application
  public static final fflib_Application.DomainFactory Domain = new fflib_Application.DomainFactory(
    Application.Selector,
    new Map<SObjectType, Type>{
      Lead.SObjectType => Leads.Constructor.class,
      Account.SObjectType => Accounts.Constructor.class,
      Contact.SObjectType => Contacts.Constructor.class,
      Opportunity.SObjectType => Opportunities.Constructor.class,
      Case.SObjectType => Cases.Constructor.class,
      Asset.SObjectType => Assets.Constructor.class,
      Product2.SObjectType => Products.Constructor.class,
      PricebookEntry.SObjectType => PricebookEntries.Constructor.class,
      Order.SObjectType => Orders.Constructor.class,
      OrderItem.SObjectType => Orderitems.Constructor.class,
      Insurance__c.SObjectType => Insurances.Constructor.class,
      Claim__c.SObjectType => Claims.Constructor.class,
      Certification__C.SObjectType => Certifications.Constructor.class,
      Contact_Certification__c.SObjectType => ContactCertifications.Constructor.class,
      Mission__c.SObjectType => Missions.Constructor.class,
      Product2.SObjectType => Products.Constructor.class,
      Order_Event__e.SObjectType => OrderEvents.Constructor.class,
      Wellness_Journey__c.SObjectType => WellnessJourneys.Constructor.class,
      Accessibility_Project__c.SObjectType => AccessibilityProjects.Constructor.class,
      BatchApexErrorEvent.SObjectType => BatchApexErrorEvents.Constructor.class
    }
  );
}