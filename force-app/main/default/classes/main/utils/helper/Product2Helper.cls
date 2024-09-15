public class Product2Helper {

    /**
     * @name COLLABORATION_GROUP
     * @description List of CollaborationGroup used in both business and test logic
    **/
    static List<CollaborationGroup> COLLABORATION_GROUP = [
        SELECT Id
        FROM CollaborationGroup
        WHERE Name = :Constants.INVENTORY_ANNOUNCEMENTS
        OR Name = :('TEST'+Constants.INVENTORY_ANNOUNCEMENTS)
        LIMIT 1
    ];
    /**
     * @name afterUpdate
     * @description called by product2 Trigger on After Update
     * @param List<Product2> newList
     * @param List<Product2> oldList
    **/
    public static void AfterUpdate(List<Product2> newList, List<Product2> oldList){
        List<Product2> needsAnnouncement = new List<Product2>();
        //ToDo: Declare a List of Product2 records named needsAnnouncement
        Map<String, Inventory_Setting__mdt> InventorySettingMap = new Map<String, Inventory_Setting__mdt>();   
        //ToDo: Declare a Map of Strings to Inventory_Setting__mdt records
        for (Inventory_Setting__mdt InventorySetting : [SELECT DeveloperName, Label, Low_Quantity_Alert__c FROM Inventory_Setting__mdt]) {
            InventorySettingMap.put(InventorySetting.Label, InventorySetting);
        }
        //ToDo: Loop through a query of Inventory_Setting__mdt records and populate the Map with Name as the key
        for (Product2 thisProduct : newList) {
            if (InventorySettingMap.get(thisProduct.Family).Low_Quantity_Alert__c > thisProduct.Quantity_Remaining__c) {
                needsAnnouncement.add(thisProduct);
            }
        }

        if (needsAnnouncement.size() > 0) {
            PostAlerts(needsAnnouncement);
        }
        //ToDo: Loop through the Products in newList
        // Use the corresponding Inventory Setting record to determine the correct Low Quantity Alert
        // If the Product's Quantity Remaining has been changed to less than the Low Quantity Alert
        //      add it to the needsAnnouncement list

        //ToDo: Pass records to the postAlerts method
    }

    /**
     * @name postAlerts
     * @description called by product2 Trigger on After Update
     * @param List<Product2> productList
    **/
    public static void PostAlerts(List<Product2> productList){
       CSUtils.debugSObjectList(COLLABORATION_GROUP);
        List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();
        for ( Product2 thisProduct : productList ){ 
            ConnectApi.AnnouncementInput announcementInput = new ConnectApi.AnnouncementInput();
            announcementInput.body = new ConnectApi.MessageBodyInput();
            announcementInput.body.messageSegments = new List<ConnectApi.MessageSegmentInput>();
            announcementInput.parentId = COLLABORATION_GROUP[0].ID;

            ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
            textSegment.text = thisProduct.Name + '' + Constants.INVENTORY_LEVEL_LOW;
            announcementInput.body.messageSegments.add(textSegment);
            
            announcementInput.expirationDate = Date.today().addDays(1);
            toPost.add(announcementInput);
            // ToDo: Construct a new AnnouncementInput for the Chatter Group so that it:
            // expires in a day
            // does not notify users via email.
            // and has a text body that includes the name of the product followed by the INVENTORY_LEVEL_LOW constant
        }
        if (toPost.size() > 0) {
            AnnouncementQueueable.PostAnnouncements(toPost);
        }
        // ToDo: Create and enqueue an instance of the announcementQueuable class with the list of Products
    }
}