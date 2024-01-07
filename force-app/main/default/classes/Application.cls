public class Application {
  // Configure and create the UnitOfWorkFactory for this Application
  public static final fflib_Application.UnitOfWorkFactory UnitOfWork = new fflib_Application.UnitOfWorkFactory(
    new List<SObjectType>{
      Lead.SObjectType,
      Account.SObjectType,
      Contact.SObjectType,
      Opportunity.SObjectType,
      Product2.SObjectType,
      PricebookEntry.SObjectType,
      OpportunityLineItem.SObjectType,
      Task.SObjectType
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
      Lead.SObjectType => LeadsSelector.class
    }
  );

  // Configure and create the DomainFactory for this Application
  public static final fflib_Application.DomainFactory Domain = new fflib_Application.DomainFactory(
    Application.Selector,
    new Map<SObjectType, Type>{
      Lead.SObjectType => Leads.Constructor.class,
      Account.SObjectType => Accounts.Constructor.class,
      Contact.SObjectType => Contacts.Constructor.class,
      Opportunity.SObjectType => Opportunities.Constructor.class
    }
  );
}
