public class OrderEvents extends fflib_SObjects implements IOrderEvents {
  public static IOrderEvents newInstance(List<Order_Event__e> recordList) {
    return (IOrderEvents) Application.Domain.newInstance(recordList);
  }

  public static IOrderEvents newInstance(Set<Id> recordIdSet) {
    return (IOrderEvents) Application.Domain.newInstance(recordIdSet);
  }

  public OrderEvents(List<Order_Event__e> sObjectList) {
    super(sObjectList, Schema.Order_Event__e.SObjectType);
  }

  public List<Order_Event__e> getOrderEvents() {
    return (List<Order_Event__e>) getRecords();
  }

  public Map<ID, Order_Event__e> getOrderEventsMap() {
    return new Map<ID, Order_Event__e>(getOrderEvents());
  }

  public void processOrderEvents(fflib_ISObjectUnitOfWork theUnitOfWork) {
    for (Order_Event__e orderEvent : getOrderEvents()) {
      if (orderEvent.Has_Shipped__c == true) {
        Task thisTask = new Task();
        thisTask.Priority = 'Medium';
        thisTask.Subject = 'Follow up on shipped order 105';
        thisTask.OwnerId = orderEvent.CreatedById;
        theUnitOfWork.registerNew(thisTask);
      }
    }
  }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new OrderEvents((List<SObject>) objectList);
    }
  }
}
