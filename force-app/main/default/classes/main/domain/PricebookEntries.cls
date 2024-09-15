public class PricebookEntries extends fflib_SObjects implements IPricebookEntries {
    public static IPricebookEntries newInstance(List<PricebookEntry> recordList) {
      return (IPricebookEntries) Application.Domain.newInstance(recordList);
    }
  
    public static IPricebookEntries newInstance(Set<Id> recordIdSet) {
      return (IPricebookEntries) Application.Domain.newInstance(recordIdSet);
    }
  
    public PricebookEntries(List<PricebookEntry> sObjectList) {
      super(sObjectList, Schema.PricebookEntry.SObjectType);
    }
  
    public List<PricebookEntry> getPricebookEntries() {
      return (List<PricebookEntry>) getRecords();
    }
  
    public Map<ID, PricebookEntry> getPricebookEntriesMap() {
      return new Map<ID, PricebookEntry>(getPricebookEntries());
    }
  
    public class Constructor implements fflib_IDomainConstructor {
      public fflib_SObjects construct(List<Object> objectList) {
        return new PricebookEntries((List<SObject>) objectList);
      }
    }
}