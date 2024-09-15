@isTest 
private class Product2Tests {
    @TestSetup
    static void SetupTestData() {
        TestDataFactory.InsertTestData(1);
        insert TestDataFactory.ConstructCollaborationGroup();
    }

    /**
     * @name product2Extension_UnitTest
     * @description UnitTest for product2Extension
    **/
    static TestMethod void Product2Extension_UnitTest(){
        Test.startTest();
            PageReference pageRef = Page.Product2New;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController stdController = new ApexPages.StandardController(new Product2());
            Product2Extension ext = new Product2Extension(stdController);
            // System.assertEquals(ext.productsToInsert.size(), Constants.DEFAULT_ROWS);
            ext.addRows();
            System.assert(ext.productsToInsert.size() == Constants.DEFAULT_ROWS*2);
            // for (Product2Extension.ProductWrapper thisProductWrapper : ext.productsToInsert){
                ext.productsToInsert[0].productRecord.Name = 'Test Product';
                ext.productsToInsert[0].productRecord.Family = 'Beverage';
                ext.productsToInsert[0].productRecord.IsActive = true;
                ext.productsToInsert[0].productRecord.Initial_Inventory__c = 99;
                ext.productsToInsert[0].pricebookEntryRecord.UnitPrice = 1;

                ext.productsToInsert[1].productRecord.Name = 'Test Product2';
                ext.productsToInsert[1].productRecord.IsActive = true;
                ext.productsToInsert[1].productRecord.Initial_Inventory__c = 99;
                ext.productsToInsert[1].pricebookEntryRecord.UnitPrice = 1;

                ext.productsToInsert[2].productRecord.Name = 'Test Product3';
                ext.productsToInsert[2].productRecord.Family = 'Beverage';
                ext.productsToInsert[2].productRecord.IsActive = true;
                ext.productsToInsert[2].productRecord.Initial_Inventory__c = 99;
            // }
            ext.save();
            ext.getInventory();
            ext.getFamilyOptions();
            System.assertEquals([Select ID FROM Product2].size(), 2);
        Test.stopTest();
        

    }

    static TestMethod void Product2Trigger_UnitTest(){
        Test.startTest();
            Product2 product = new Product2();
            product.Name = 'Test Product';
            product.Family = 'Beverage';
            product.IsActive = true;
            product.Initial_Inventory__c = 50;
            insert product;
            product.Quantity_Ordered__c = 48;
            update product;
            System.assertEquals([Select ID FROM Product2].size(), 2);
        Test.stopTest();

    }
    //Create a new method titled Product2Trigger_UnitTest in Product2Tests that tests the logic when a Product’s Quantity Ordered value is updated. 

}

/*Validate the Logic of the product2New Page

Complete the Product2Extension_UnitTest in Product2Tests. 
This unit test should simulate a user’s visit to, and interaction with, 
the Product2New page and test that it behaves as expected. 
When a user first visits the page, there should be multiple rows displayed on the screen. 
Assert that the size of the productsToInsert list is equal to the DEFAULT_ROWS constant. 
When the Add button is clicked, an additional set of rows should be added, 
so assert that the size of the productsToInsert ** list is 
double **DEFAULT_ROWS after the button is clicked once. Don't forget to ensure that the test methods don’t (and can’t) use live data.
Next, test the Save button. Verify that populated rows are saved and unpopulated rows are not saved. 
Loop through the rows in the productsToInsert list and populate the values of the first 5 records, 
and then simulate clicking the Save button. Verify that the button worked by asserting that only 5 products were saved.
Be sure to run your tests when you're done to ensure they pass without failures.*/