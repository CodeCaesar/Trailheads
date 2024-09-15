public interface IOrdersSelector extends fflib_ISObjectSelector {
    List<Order> selectAll();
    List<Order> selectByAccountId(Id accountId);
    List<Order> selectWithOrderItems(Set<ID> orderIDSet);

}