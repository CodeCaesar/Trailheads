public interface ILeads extends fflib_ISObjects {
  List<Lead> getLeads();
  Map<ID, Lead> getLeadsMap();
  void setFieldValueForAll(
    fflib_ISObjectUnitOfWork theUnitOfWork,
    String apiString,
    String valueString
  );
}
