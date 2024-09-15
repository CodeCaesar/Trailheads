public interface IWellnessJourneysSelector {
    List<Wellness_Journey__c> selectAll();
    List<Wellness_Journey__c> selectCompletedByDateRange(Date startDate, Date endDate);
    Database.QueryLocator queryLocatorSelectCompletedByDateRange(Date startDate, Date endDate);
}