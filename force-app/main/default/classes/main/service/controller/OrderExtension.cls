/**
 * @name OrderExtension
 * @description This class is provided for you to facilitate the Super Badge
**/
public class OrderExtension {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance(); 
    public Order orderRecord {get;set;}
    public List<OrderItem> orderItemList {get;set;}
    public String selectedFamily {get;set;}
    public List<chartHelper.chartData> pieData {get;set;}
    public Decimal total {get;set;}
    public Integer totalPages {get;set;}
    public Integer totalRecords { get; private set; }
    public Integer pageSize { get; private set; }
    public Integer pageNumber { get; private set; }
    public IOrderItems theseOrderItems;
    public String filterValue { get; private set; }

    public Map<Id,OrderItem> orderItemMap;
    ApexPages.StandardSetController standardSetController;

    public OrderExtension(ApexPages.StandardController standardController){
        orderRecord = (Order)standardController.getRecord();
        orderItemMap = new Map<id,OrderItem>();
        this.pageSize = Constants.DEFAULT_ROWS;
        this.selectedFamily = '';
        if ( orderRecord.Id != null ){
            orderRecord = queryOrderRecord(orderRecord.Id);
            IOrders theseOrders = Orders.newInstance(new List<Order>{orderRecord});
        } 
        loadPricebookEntries();
    }

    public void loadPricebookEntries() {
        Set<ID> product2IDSet = new Set<ID>{};
        List<String> familyList = new List<String>();
        if (orderRecord.Id != null) {
            IOrderItems theseOrderItems = OrderItems.newInstance(OrderItemsSelector.newInstance().selectByOrderId(orderRecord.Id));
            orderItemMap = theseOrderItems.getProduct2OrderItemMap();
        }
        List<PricebookEntry> thesePricebookEntry = new List<PricebookEntry>();
        if (!selectedFamily.equalsIgnoreCase('')) {
            familyList.add(selectedFamily);  
        } 
        thesePricebookEntry = PricebookEntriesSelector.newInstance().selectByProduct2AndFamily(product2IDSet, familyList);
        CSUtils.debugSObjectList(thesePricebookEntry);
        standardSetController = new ApexPages.StandardSetController(thesePricebookEntry);
        this.totalPages = (Integer) Math.ceil((Double)this.standardSetController.getResultSize() / Constants.DEFAULT_ROWS);
        standardSetController.setPageSize(Constants.DEFAULT_ROWS);
        loadOrderitems();
    }

    public void loadOrderitems() {
        orderItemList = new List<OrderItem>();
        for (SObject  thisRecord : standardSetController.getRecords()) {
            PricebookEntry thisPricebookEntry = (PricebookEntry)thisRecord;
            if (orderItemMap.get(thisPricebookEntry.Product2Id) != null) {
                orderItemList.add(orderItemMap.get(thisPricebookEntry.Product2Id));
            } else {
                Product2 thisProduct2 = new Product2();
                thisProduct2.ID = thisPricebookEntry.Product2Id;
                thisProduct2.Family = thisPricebookEntry.ProductFamily__c;
                OrderItem thisOrderItem = new OrderItem();
                thisOrderItem.Product2Id = thisPricebookEntry.Product2Id;
                thisOrderItem.UnitPrice = thisPricebookEntry.UnitPrice;
                thisOrderItem.Quantity = 0;
                if (orderRecord.Id != null) thisOrderItem.OrderId = orderRecord.Id;
                thisOrderItem.PricebookEntryId = thisPricebookEntry.Id;
                thisOrderItem.Product2 = thisProduct2;
                orderItemList.add(thisOrderItem);
            }
        
        }
    }

    public void loadPieChartData() {
        pieData = new List<ChartHelper.ChartData>();
        for (OrderItem thisOrderItem : orderItemMap.values()) {
            if (thisOrderItem.ProductFamily__c == selectedFamily && checkFields(thisOrderItem)) {
                pieData.add(new ChartHelper.ChartData(thisOrderItem.ProductName__c, thisOrderItem.Quantity * thisOrderItem.UnitPrice));
            }

        }
    }

    //ToDo: Implement your own method to populate orderItemList
    //  that you will call after pagination and/or family selection


    /**
     * @name OnFieldChange
     * @description
    **/
    public void OnFieldChange(){
        for (OrderItem thisOrderItem : orderItemList) {
            orderItemMap.put(thisOrderItem.Product2Id, thisOrderItem);
        }
        loadOrderitems();
        loadPieChartData();
    }

    /**
     * @name SelectFamily
     * @description
    **/
    public void SelectFamily(){
        loadPricebookEntries();
    }

    /**
     * @name Save
     * @description
    **/
    public void Save(){
        Savepoint sp = Database.setSavepoint();
        try{
            orderRecord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
            upsert orderRecord;
            for (OrderItem thisOrderItem : orderItemMap.values()) {
                if (checkFields(thisOrderItem)) {
                    if (thisOrderItem.Id != null) {
                        theUnitOfWork.registerDirty(thisOrderItem);
                    } else {
                        thisOrderItem.OrderId = orderRecord.Id;
                        theUnitOfWork.registerNew(thisOrderItem);
                    }
                    
                } else if (thisOrderItem.id != null) {
                    theUnitOfWork.registerDeleted(thisOrderItem);
                } 
            }
            theUnitOfWork.commitWork();
        } catch (Exception exe){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An error occurred while saving: ' + exe.getMessage()));
        }

    }

    public Boolean checkFields(OrderItem orderItem) {
        if (orderItem.Product2Id == null) {
            return false;
        }

        if (orderItem.Quantity == null || orderItem.Quantity <= 0) {
            return false;
        }

        if (orderItem.UnitPrice == null || orderItem.UnitPrice <= 0) {
            return false;
        }
        return true;
    }

    public void First() {
        this.standardSetController.first();
        loadOrderitems();
    }

    public void Last() {
        this.standardSetController.last();
        loadOrderitems();
    }

    public void Next() {
        this.standardSetController.next();
        loadOrderitems();
    }

    public void Previous() {
        this.standardSetController.previous();
        loadOrderitems();
    }

    public Boolean GetHasNext() {
        return standardSetController.getHasNext();
    }

    public Boolean getHasPrevious() {
        return standardSetController.getHasPrevious();
    }


    /**
     * @name GetFamilyOptions
     * @description
    **/

    public List<SelectOption> getFamilyOptions() {
        List<SelectOption> familyOptions = new List<SelectOption>();
        familyOptions.add(new SelectOption(Constants.SELECT_ONE, Constants.SELECT_ONE));
        for (Schema.PicklistEntry entry : Constants.PRODUCT_FAMILY) {
            familyOptions.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
        return familyOptions;
    }

        /**
     * @name GetTotalPages
     * @description
    **/
    public Integer GetTotalPages(){
        System.debug(totalPages);
        return totalPages;
    }
    
    public Integer GetPageNumber() {
        return standardSetController.getPageNumber();
    }
    /**
     * @name QueryOrderRecord
     * @description
    **/
    public static Order QueryOrderRecord(Id orderId){
        return OrdersSelector.newInstance().selectWithOrderItems(new Set<ID>{orderId})[0];
    }

}