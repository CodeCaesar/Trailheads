public class OrderItemsSelector extends fflib_SObjectSelector implements IOrderItemsSelector {
    public static IOrderItemsSelector newInstance() {
      return (IOrderItemsSelector) Application.Selector.newInstance(
        OrderItem.SObjectType
      );
    }
  
    public List<Schema.SObjectField> getSObjectFieldList() {
      return new List<Schema.SObjectField>{
        OrderItem.Id,
        OrderItem.OrderId,
        OrderItem.PricebookEntryId,
        OrderItem.Quantity,
        OrderItem.UnitPrice,
        OrderItem.TotalPrice,
        OrderItem.Description,
        OrderItem.Product2Id,
        OrderItem.ProductName__c,
        OrderItem.ProductFamily__c,
        OrderItem.Quantity_Remaining__c
      };
    }
  
    public Schema.SObjectType getSObjectType() {
      return OrderItem.SObjectType;
    }
  
    public List<OrderItem> selectAll() {
      return (List<OrderItem>) Database.query(newQueryFactory().toSOQL());
    }
  
    public List<OrderItem> selectByOrderId(Id orderId) {
      return (List<OrderItem>) Database.query(
        newQueryFactory()
          .setCondition('OrderId =: orderId')
          .toSOQL()
      );
    }

    public Database.QueryLocator queryLocatorSelectAll() {
      return Database.getQueryLocator(newQueryFactory().toSOQL());
    }

    public Database.QueryLocator queryLocatorSelectByOrderId(Set<ID> orderIdSet) {
      return Database.getQueryLocator(newQueryFactory()
        .setCondition('OrderId in: orderIdSet')
        .toSOQL());
    }
    public Database.QueryLocator queryLocatorSelectByOrderIdAndFamily(Set<ID> orderIdSet, String familyString) {
      return Database.getQueryLocator(newQueryFactory()
        .setCondition('OrderId in: orderIdSet')
        .setCondition('ProductFamily__c =: familyString')
        .toSOQL());
    }
  }