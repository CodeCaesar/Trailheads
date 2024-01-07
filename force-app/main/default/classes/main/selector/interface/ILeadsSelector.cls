public interface ILeadsSelector extends fflib_ISObjectSelector {
  List<Lead> selectAll();
  Database.QueryLocator queryLocatorSelectAll();
}
