public interface IWellnessJourneys {
    List<Wellness_Journey__c> getWellnessJourneys();
    Map<ID, Wellness_Journey__c> getWellnessJourneysMap();
    List<Map<String, Object>> getCompletedUsersListMap();
    String serializeCompletedUsersList();
}