public class OrdersSelector extends fflib_SObjectSelector implements IOrdersSelector {
    public static IOrdersSelector newInstance() {
      return (IOrdersSelector) Application.Selector.newInstance(
        Order.SObjectType
      );
    }
  
    public List<Schema.SObjectField> getSObjectFieldList() {
      return new List<Schema.SObjectField>{
        Order.Id,
        Order.AccountId,
        Order.Status,
        Order.EffectiveDate,
        Order.ContractId,
        Order.TotalAmount,
        Order.Description,
        Order.OrderNumber
      };
    }
  
    public Schema.SObjectType getSObjectType() {
      return Order.SObjectType;
    }
  
    public List<Order> selectAll() {
      return (List<Order>) Database.query(newQueryFactory().toSOQL());
    }
  
    public List<Order> selectByAccountId(Id accountId) {
      return (List<Order>) Database.query(
        newQueryFactory()
          .setCondition('AccountId =: accountId')
          .toSOQL()
      );
    }
  
    public List<Order> selectWithOrderItems(Set<ID> orderIDSet) {
      OrderItemsSelector orderItemSelect = new OrderItemsSelector();
      fflib_QueryFactory orderQueryFactory = newQueryFactory();
      orderQueryFactory.setCondition('id in: orderIDSet');
      orderItemSelect.addQueryFactorySubselect(orderQueryFactory);
      return Database.query(orderQueryFactory.toSOQL());
    }
  
}