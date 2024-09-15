public interface IOrderItems extends fflib_ISObjects {
    List<OrderItem> getOrderItems();
    Map<ID, OrderItem> getOrderItemsMap();
    List<OrderItem> getOrderItemsByFamily(String key);
    Map<ID, OrderItem> getProduct2OrderItemMap();
    Set<ID> getProduct2Ids();
}