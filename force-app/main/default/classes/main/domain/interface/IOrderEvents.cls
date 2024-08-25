public interface IOrderEvents extends fflib_ISObjects {
  List<Order_Event__e> getOrderEvents();
  Map<ID, Order_Event__e> getOrderEventsMap();
  void processOrderEvents(fflib_ISObjectUnitOfWork theUnitOfWork);
}
