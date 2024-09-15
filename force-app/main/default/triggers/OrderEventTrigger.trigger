trigger OrderEventTrigger on Order_Event__e(after insert) {
  static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
  IOrderEvents theseOrderEvents = OrderEvents.newInstance(Trigger.new);
  theseOrderEvents.processOrderEvents(theUnitOfWork);
  theUnitOfWork.commitWork();
}