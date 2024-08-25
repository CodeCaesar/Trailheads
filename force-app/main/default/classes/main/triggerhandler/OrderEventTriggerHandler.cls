public class OrderEventTriggerHandler extends fflib_SObjectDomain {
  static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
  public OrderEventTriggerHandler(List<SObject> sObjectList) {
    super(sObjectList);
  }

  // Method to handle after insert event
  //If the order has shipped (event.Has_Shipped__c == true), create a task with the following values:
  //Priority: 'Medium'
  //Subject: 'Follow up on shipped order 105'
  //OwnerId: event.CreatedById
  //Note: You are assigning the task OwnerId to the same user who published the event. This step keeps things simple so you don't have to perform any prerequisites.
  public override void handleAfterInsert() {
    System.debug('Hello World');
    IOrderEvents theseOrderEvents = OrderEvents.newInstance(
      (List<Order_Event__e>) Records
    );
    theseOrderEvents.processOrderEvents(theUnitOfWork);
    theUnitOfWork.commitWork();
  }
}
