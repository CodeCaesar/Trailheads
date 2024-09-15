public interface IOrders extends fflib_ISObjects {
    List<Order> getOrders();
    Map<ID, Order> getOrdersMap();
    Map<ID, List<OrderItem>> getOrdersItemsMap();
}