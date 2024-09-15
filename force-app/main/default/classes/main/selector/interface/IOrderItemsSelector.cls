public interface IOrderItemsSelector extends fflib_ISObjectSelector {
    List<OrderItem> selectAll();
    List<OrderItem> selectByOrderId(Id orderId);
    Database.QueryLocator queryLocatorSelectAll();
    Database.QueryLocator queryLocatorSelectByOrderId(Set<ID> orderIdSet);
    Database.QueryLocator queryLocatorSelectByOrderIdAndFamily(Set<ID> orderIdSet, String familyString);
  }