public interface IProductsSelector extends fflib_ISObjectSelector {
  List<Product2> selectAll();
  List<Product2> selectWithEquipmentMaintenanceItems(Set<ID> productIDSet);
  List<Product2> selectByProductCode(List<String> productCodeList);
}
