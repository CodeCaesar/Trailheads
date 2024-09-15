public interface ICasesSelector extends fflib_ISObjectSelector {
  List<Case> selectAll();
  List<Case> selectWithMaintenanceRequestsAndProducts(Set<ID> caseIDSet);
}