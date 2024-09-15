public interface IPricebookEntries extends fflib_ISObjects {
    List<PricebookEntry> getPricebookEntries();
    Map<ID, PricebookEntry> getPricebookEntriesMap();
}