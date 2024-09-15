public class Constants {
    public static final Integer DEFAULT_ROWS = 5; // An Integer used to control the number of rows displayed by a Visualforce page.
    public static final String SELECT_ONE = 'Select one'; // A String used to populate picklist values in Visualforce Pages.
    public static final String INVENTORY_LEVEL_LOW = 'Has a low inventory'; // A String used to determine the threshold that causes low inventory alerts.
    public static final List<Schema.PicklistEntry> PRODUCT_FAMILY = new List<Schema.PicklistEntry>{
        (Schema.PicklistEntry) JSON.deserialize('{"value":"Entree","label":"Entree","active":true,"defaultValue":false}', Schema.PicklistEntry.class),
        (Schema.PicklistEntry) JSON.deserialize('{"value":"Side","label":"Side","active":true,"defaultValue":false}', Schema.PicklistEntry.class),
        (Schema.PicklistEntry) JSON.deserialize('{"value":"Dessert","label":"Dessert","active":true,"defaultValue":false}', Schema.PicklistEntry.class),
        (Schema.PicklistEntry) JSON.deserialize('{"value":"Beverage","label":"Beverage","active":true,"defaultValue":false}', Schema.PicklistEntry.class)
    }; // A list used to populate picklist values in Visualforce pages.
    public static final String DRAFT_ORDER_STATUS = 'Draft'; // A String used to indicate that an order is a “draft”—an order that is in flight. You can’t activate a draft order unless you have a line item, and you can’t have a line item unless you have an order saved in the system.
    public static final String ACTIVATED_ORDER_STATUS = 'Activated'; // A String used to evaluate if an Order is Activated or not.
    public static final String INVENTORY_ANNOUNCEMENTS = 'Inventory Announcements'; // A String used to query a Chatter Group by Name.
    public static final String ERROR_MESSAGE = 'An error has occurred, please take a screenshot with the URL and send it to IT.'; // A String used to display user friendly error messages on Visualforce pages.
    public static final Id STANDARD_PRICEBOOK_ID = '01sbm000004AvQwAAK'; // An Id used to create Orders and PricebookEntries in business and test code.

//     "Name","Value","Purpose"
//     "DEFAULT_ROWS","5","An Integer used to control the number of rows displayed by a Visualforce page."
//     "SELECT_ONE","Value of the corresponding custom label","A String used to populate picklist values in Visualforce Pages."
//     "INVENTORY_LEVEL_LOW","Value of the corresponding custom label","A String used to determine the threshold that causes low inventory alerts."
//     "PRODUCT_FAMILY","List of Schema.PicklistEntry for the Family field on the Product2 object. This list is dynamic and must always reflect the currently configured values.","A list used to populate picklist values in Visualforce pages."
//     "DRAFT_ORDER_STATUS","Draft","A String used to indicate that an order is a “draft”—an order that is in flight.  You can’t activate a draft order unless you have a line item, and you can’t have a line item unless you have an order saved in the system."
//     "ACTIVATED_ORDER_STATUS","Activated","A String used to evaluate if an Order is Activated or not."
//     "INVENTORY_ANNOUNCEMENTS","Inventory Announcements","A String used to query a Chatter Group by Name."
//     "ERROR_MESSAGE","An error has occurred, please take a screenshot with the URL and send it to IT.","A String used to display user friendly error messages on Visualforce pages."
//     "STANDARD_PRICEBOOK_ID","Value of the Standard Pricebook Id","An Id used to create Orders and PricebookEntries in business and test code.   Note: Normally, we would recommend doing a query and using Test.getStandardPricebookId() to get the standard pricebook Id, however, since this code is being used for both business and test logic, that’s not possible.  In fact, just calling  Test.getStandardPricebookId() from outside of a test method will throw a system exception.  That would make it very hard on us to ensure that you completed this step properly."
// }
}