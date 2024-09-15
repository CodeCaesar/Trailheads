public without sharing class Product2Extension {
    static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    public List<ProductWrapper> productsToInsert { get; set; }
    public List<ChartHelper.ChartData> chartData { get; set; }

    // Constructor that takes the standard controller
    public Product2Extension(ApexPages.StandardController stdController) {
        // ProductWrapper productWrapper = new ProductWrapper();
        productsToInsert = new List<ProductWrapper>();
        addRows();
    }

    public void addRows() {
        for (Integer i = 0; i < Constants.DEFAULT_ROWS; i++) {
            ProductWrapper productWrapper = new ProductWrapper();
            productsToInsert.add(productWrapper);
        }
    }

    public List<ChartHelper.ChartData> getInventory() {
        return ChartHelper.getInventory();
    }

    public List<SelectOption> getFamilyOptions() {
        List<SelectOption> familyOptions = new List<SelectOption>();
        familyOptions.add(new SelectOption(Constants.SELECT_ONE, Constants.SELECT_ONE));
        for (Schema.PicklistEntry entry : Constants.PRODUCT_FAMILY) {
            familyOptions.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
        return familyOptions;
    }

    public PageReference save() {
        Savepoint sp = Database.setSavepoint();
        try {
            for (ProductWrapper productWrapper : productsToInsert) {
// Execute Anonymous: ext.productsToInsert[i].productRecord.Family = 'Entree';
// Execute Anonymous: ext.productsToInsert[i].productRecord.IsActive = true;
// Execute Anonymous: ext.productsToInsert[i].productRecord.Initial_Inventory__c = 99;
// Execute Anonymous: ext.productsToInsert[i].pricebookEntryRecord.UnitPrice = 1;
                if (checkProductWrapperFields(productWrapper)) {

//                         Name: This field is part of the Product2 object.
// Family: This field is part of the Product2 object.
// IsActive: This field is part of the Product2 object.
// Initial_Inventory__c: This field is a custom field on the Product2 object.
// UnitPrice: This field is a custom field added to the ProductWrapper class.
                    // productWrapper.pricebookEntryRecord.IsActive = true;
                    productWrapper.pricebookEntryRecord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
                    theUnitOfWork.registerNew(productWrapper.productRecord);
                    theUnitOfWork.registerNew(productWrapper.pricebookEntryRecord, PricebookEntry.Product2Id, productWrapper.productRecord);

                }
            }
            theUnitOfWork.commitWork();
            // If successful, clear the list and display an informational message
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, productsToInsert.size() + ' Inserted'));
            productsToInsert.clear(); // Do not remove
            addRows(); // Do not remove
        } catch (Exception e) {
            Database.rollback(sp); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Constants.ERROR_MESSAGE));
        }
        return null;
    }

    public Boolean checkProductWrapperFields(ProductWrapper productWrapper) {
        if (productWrapper.productRecord.Name == null || productWrapper.productRecord.Name.equalsIgnoreCase('')) {
            return false;
        }

        if (productWrapper.productRecord.Initial_Inventory__c == null || productWrapper.productRecord.Initial_Inventory__c == 0) {
            return false;
        }

        // if (productWrapper.productRecord.IsActive == null || productWrapper.productRecord.IsActive == false) {
        //     return false;
        // }

        if (productWrapper.productRecord.Family == null || productWrapper.productRecord.Family.equalsIgnoreCase(Constants.SELECT_ONE)) {
            return false;
        }

        if (productWrapper.pricebookEntryRecord.UnitPrice == null || productWrapper.pricebookEntryRecord.UnitPrice == 0) {
            return false;
        }

        return true;
    }

    public class ProductWrapper{
        public product2 productRecord {get;set;}
        public pricebookEntry pricebookEntryRecord{get;set;}
        public productWrapper(){
            productRecord = new product2(Initial_Inventory__c =0);
            pricebookEntryRecord = new pricebookEntry(Unitprice=0.0);
        }
    }
}