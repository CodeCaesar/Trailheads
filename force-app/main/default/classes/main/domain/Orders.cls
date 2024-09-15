public class Orders extends fflib_SObjects implements IOrders {
    public static IOrders newInstance(List<Order> recordList) {
      return (IOrders) Application.Domain.newInstance(recordList);
    }
  
    public static IOrders newInstance(Set<Id> recordIdSet) {
      return (IOrders) Application.Domain.newInstance(recordIdSet);
    }
  
    public Orders(List<Order> sObjectList) {
      super(sObjectList, Schema.Order.SObjectType);
    }
  
    public List<Order> getOrders() {
      return (List<Order>) getRecords();
    }
  
    public Map<ID, Order> getOrdersMap() {
      return new Map<ID, Order>(getOrders());
    }
  
    public Map<ID, List<OrderItem>> getOrdersItemsMap() {
      Map<ID, List<OrderItem>> ordersItemsMap = new Map<ID, List<OrderItem>>();
      for (Order thisOrder : getOrders()) {
        for (OrderItem thisOrderItem : thisOrder.OrderItems) {
          if (ordersItemsMap.get(thisOrder.ID) == null) {
            ordersItemsMap.put(thisOrder.ID, new List<OrderItem>{ thisOrderItem });
          } else {
            ordersItemsMap.get(thisOrder.ID).add(thisOrderItem);
          }
        }
      }
      return ordersItemsMap;
    }
  
  
    public class Constructor implements fflib_IDomainConstructor {
      public fflib_SObjects construct(List<Object> objectList) {
        return new Orders((List<SObject>) objectList);
      }
    }
  }