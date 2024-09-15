/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
**/
public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static CollaborationGroup ConstructCollaborationGroup(){
        String groupName = 'TEST' + Constants.INVENTORY_ANNOUNCEMENTS;
        ATK.SaveResult result = ATK.prepare(CollaborationGroup.SObjectType, 1)
                                                .field(CollaborationGroup.Name)
                                                .index(groupName)
                                                .field(CollaborationGroup.CollaborationType)
                                                .repeat('Public')
                                                .field(CollaborationGroup.Description)
                                                .repeat('This is a test group for inventory announcements.')
                                                .field(CollaborationGroup.InformationTitle)
                                                .repeat('Inventory Announcements')
                                                .field(CollaborationGroup.InformationBody)
                                                .repeat('This group is used for inventory-related announcements.')
                                                .field(CollaborationGroup.IsArchived)
                                                .repeat(false)
                                                .field(CollaborationGroup.IsBroadcast)
                                                .repeat(false)
                                                .save(false);

            // result.get(CollaborationGroup.SObjectType)[0].ID = null;
            return (CollaborationGroup)result.get(CollaborationGroup.SObjectType)[0];
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public static List<Product2> ConstructProducts(Integer cnt){
        List<Object> familyList = new List<Object>();
        for (Schema.PicklistEntry thisPictlist : Constants.PRODUCT_FAMILY) {
            familyList.add(thisPictlist.getValue());
        }
        ATK.SaveResult result = ATK.prepare(Product2.SObjectType, cnt)
                                                .field(Product2.Name)
                                                .index('TestProduct-{0000}')
                                                .field(Product2.ProductCode)
                                                .repeat('TP-0000')
                                                .field(Product2.IsActive)
                                                .repeat(true)
                                                .field(Product2.Description)
                                                .repeat('This is a test product for inventory.')
                                                .field(Product2.Family)
                                                .repeat(familyList)
                                                .field(Product2.Initial_Inventory__c)
                                                .repeat(10)
                                                .save(false);
        
        return (List<Product2>)result.get(Product2.SObjectType);                                         
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
    }

    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PricebookEntry> ConstructPricebookEntries(List<Product2> prods){
            // Prepare PricebookEntry records
        ATK.SaveResult result = ATK.prepare(PricebookEntry.SObjectType, prods.size())
                                                .field(PricebookEntry.IsActive)
                                                .repeat(true)
                                                .field(PricebookEntry.Pricebook2Id)
                                                .repeat(Constants.STANDARD_PRICEBOOK_ID)
                                                .field(PricebookEntry.UseStandardPrice)
                                                .repeat(false)
                                                .field(PricebookEntry.Product2Id)
                                                .repeat(CSUtils.convertListToIdList(prods))
                                                .field(PricebookEntry.UnitPrice)
                                                .repeat(100.0)
                                                .save(false);

        return (List<PricebookEntry>)result.get(PricebookEntry.SObjectType); 
        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        ATK.SaveResult result = ATK.prepare(Account.SObjectType, cnt)
                                                        .field(Account.Name)
                                                        .index('Name-{0000}')
                                                        .save(false);
        return (List<Account>)result.get(Account.SObjectType); 
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){

        ATK.SaveResult result = ATK.prepare(Contact.SObjectType, cnt)
                                                    .field(Contact.LastName)
                                                    .index('Name-{0000}')
                                                    .field(Contact.FirstName)
                                                    .index('Name-{0000}')
                                                    .field(Contact.AccountID)
                                                    .repeat(CSUtils.convertListToIdList(accts))
                                                    .save(false);

        return (List<Contact>)result.get(Contact.SObjectType); 
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        ATK.SaveResult result = ATK.prepare(Order.SObjectType, cnt)
                                                        .field(Order.Name)
                                                        .index('Order-{0000}')
                                                        .field(Order.AccountId)
                                                        .repeat(CSUtils.convertListToIdList(accts))
                                                        .field(Order.EffectiveDate)
                                                        .repeat(Date.today())
                                                        .field(Order.Pricebook2Id)
                                                        .repeat(Constants.STANDARD_PRICEBOOK_ID) // Assuming no pricebook is associated
                                                        .field(Order.Type)
                                                        .repeat('Standard')
                                                        .field(Order.Status)
                                                        .repeat('Draft')
                                                        .save(false);

        return (List<Order>)result.get(Order.SObjectType);
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
        ATK.SaveResult result = ATK.prepare(OrderItem.SObjectType, cnt)
                                                .field(OrderItem.OrderId)
                                                .repeat(CSUtils.convertListToIdList(ords))
                                                .field(OrderItem.PricebookEntryId)
                                                .repeat(CSUtils.convertListToIdList(pbes))
                                                .field(OrderItem.Quantity)
                                                .repeat(Constants.DEFAULT_ROWS)
                                                .field(OrderItem.UnitPrice)
                                                .repeat(100.0) // Assuming a default unit price
                                                .save(false);

        return (List<OrderItem>)result.get(OrderItem.SObjectType);
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static void InsertTestData(Integer cnt) {
    
        List<Account> theseAccounts = ConstructAccounts(cnt);
        insert theseAccounts;
    
        List<Contact> theseContacts = ConstructContacts(cnt, theseAccounts);
        insert theseContacts;
    
        List<Order> theseOrders = ConstructOrders(cnt, theseAccounts);
        insert theseOrders;
    
        List<Product2> theseProducts = ConstructProducts(cnt);
        insert theseProducts;
    
        List<PricebookEntry> thesePricebookEntries = ConstructPricebookEntries(theseProducts);
        insert thesePricebookEntries;

        List<OrderItem> theseOrderItems = ConstructOrderItems(cnt, thesePricebookEntries, theseOrders);
        insert theseOrderItems;
    }

    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered){
        System.assertEquals(originalProduct.Quantity_Ordered__c, updatedProduct.Quantity_Ordered__c- qtyOrdered);
    }

}