public class OrderItems extends fflib_SObjects implements IOrderItems {
    public static IOrderItems newInstance(List<OrderItem> recordList) {
      return (IOrderItems) Application.Domain.newInstance(recordList);
    }
  
    public static IOrderItems newInstance(Set<Id> recordIdSet) {
      return (IOrderItems) Application.Domain.newInstance(recordIdSet);
    }
  
    public OrderItems(List<OrderItem> sObjectList) {
      super(sObjectList, Schema.OrderItem.SObjectType);
    }
  
    public List<OrderItem> getOrderItems() {
      return (List<OrderItem>) getRecords();
    }
  
    public Map<ID, OrderItem> getOrderItemsMap() {
      return new Map<ID, OrderItem>(getOrderItems());
    }

    public List<OrderItem> getOrderItemsByFamily(String key) {
      Map<String, List<OrderItem>> orderItemsByFamily = new Map<String, List<OrderItem>>();
      for (OrderItem thisOrderItem : getOrderItems()) {
          String family = thisOrderItem.ProductFamily__c;
          if (!orderItemsByFamily.containsKey(family)) {
              orderItemsByFamily.put(family, new List<OrderItem>());
          }
          orderItemsByFamily.get(family).add(thisOrderItem);
      }

      //if key==blank return entire list of OrderItem
      return orderItemsByFamily.containsKey(key) ? orderItemsByFamily.get(key) : new List<OrderItem>();
    }

    public Map<ID, OrderItem> getProduct2OrderItemMap() {
      Map<ID, OrderItem> product2OrderItemMap = new Map<ID, OrderItem>();
      for (OrderItem thisOrderItem : getOrderItems()) {
          product2OrderItemMap.put(thisOrderItem.Product2Id, thisOrderItem);
      }
      return product2OrderItemMap;
    }

    public Set<ID> getProduct2Ids() {
      Set<ID> product2Ids = new Set<ID>();
      for (OrderItem item : getOrderItems()) {
          product2Ids.add(item.Product2Id);
      }
      return product2Ids;
    }

    // public class ProductWrapper {
    //   public Product2 productRecord { get; set; }
    //   public OrderItem orderItemRecord { get; set; }

    //   public ProductWrapper() {
    //       productRecord = new Product2(Initial_Inventory__c = 0);
    //       pricebookEntryRecord = new PriceBookEntry(Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID, UnitPrice = 0, IsActive = true);
    //   }
    // }
  
    public class Constructor implements fflib_IDomainConstructor {
      public fflib_SObjects construct(List<Object> objectList) {
        return new OrderItems((List<SObject>) objectList);
      }
    }
}