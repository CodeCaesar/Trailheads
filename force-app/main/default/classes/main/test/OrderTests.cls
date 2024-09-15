@isTest 
private class OrderTests {
    @TestSetup
    static void SetupTestData() {
        TestDataFactory.InsertTestData(20);
        insert TestDataFactory.ConstructCollaborationGroup();
    }

    @IsTest
    static void OrderExtension_UnitTest (){
        Account testAccount = new Account();
        testAccount.Name = 'test';
        insert testAccount;

        PageReference thisReference = Page.OrderEdit;
        Test.setCurrentPage(thisReference);
        orderExtension ext = new orderExtension(new apexPages.standardController(new Order()));
        
        ext.orderRecord.AccountId = testAccount.Id;
        ext.orderRecord.EffectiveDate = system.today();
        ext.orderRecord.Status = constants.DRAFT_ORDER_STATUS;
        ext.orderRecord.Pricebook2Id = constants.STANDARD_PRICEBOOK_ID;
        ext.orderItemList[0].Quantity = 1;
        ext.orderItemList[0].UnitPrice = 1;
        ext.orderItemList[1].Quantity = 2;
        ext.orderItemList[1].UnitPrice = 2;
        ext.OnFieldChange();
        ext.save();
        List<Order> savedOrders = [SELECT Id, (SELECT Quantity, UnitPrice FROM OrderItems ORDER BY Quantity) FROM Order WHERE AccountId = :testAccount.Id];
        system.assert( savedOrders.size() == 1 );
        system.assert( savedOrders[0].OrderItems.size() == 2 );
        system.assert( savedOrders[0].OrderItems[0].Quantity == 1 && savedOrders[0].OrderItems[0].UnitPrice == 1);
        system.assert( savedOrders[0].OrderItems[1].Quantity == 2 && savedOrders[0].OrderItems[1].UnitPrice == 2);
        ext = new orderExtension(new apexPages.standardController(savedOrders[0]));
        ext.orderItemList[0].Quantity = 0;
        ext.OnFieldChange();
        ext.save();
        ext.SelectFamily();
        ext.First();
        ext.Next();
        ext.Previous();
        ext.GetHasNext();
        ext.Last();
        ext.getHasPrevious();
        ext.GetTotalPages();
        ext.GetPageNumber();
        ext.getFamilyOptions();
        // IOrders theseOrders = Orders.newInstance(OrdersSelector.newInstance().selectWithOrderItems(new Set<Id>{savedOrders[0].Id}));
        // theseOrders.getOrders()[0].Status = Constants.ACTIVATED_ORDER_STATUS;
        // update theseOrders.getOrders()[0];
        
    }

    @IsTest
    static void OrderUpdate_UnitTest(){
        IOrders theseOrders = Orders.newInstance(OrdersSelector.newInstance().selectAll());
        theseOrders.getOrders()[0].Status = Constants.ACTIVATED_ORDER_STATUS;
        update theseOrders.getOrders()[0];
    }


}



// Finally, create a new test method named OrderUpdate_UnitTest in OrderTests. This method must activate the Orders created in your SetupTestData method using the ACTIVATED_ORDER_STATUS constant and then use the VerifyQuantityOrdered method to verify that the Quantity Ordered field on Products was increased by the trigger.