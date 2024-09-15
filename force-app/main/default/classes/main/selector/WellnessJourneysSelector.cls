public class WellnessJourneysSelector extends fflib_SObjectSelector implements IWellnessJourneysSelector {
    
    public static IWellnessJourneysSelector newInstance() {
        return (IWellnessJourneysSelector) Application.Selector.newInstance(Wellness_Journey__c.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            Wellness_Journey__c.Id,
            Wellness_Journey__c.Name,
            Wellness_Journey__c.Completion_Date__c,
            Wellness_Journey__c.Completion_Goal__c,
            Wellness_Journey__c.Completion_Value__c,
            Wellness_Journey__c.Description__c,
            Wellness_Journey__c.Is_Accessible__c,
            Wellness_Journey__c.Metric_Type__c,
            Wellness_Journey__c.Points__c,
            Wellness_Journey__c.Points_Earned__c,
            Wellness_Journey__c.Status__c,
            Wellness_Journey__c.Type__c,
            Wellness_Journey__c.OwnerId,
            Wellness_Journey__c.isUser__c,
            Wellness_Journey__c.isGroup__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Wellness_Journey__c.SObjectType;
    }

    public List<Wellness_Journey__c> selectAll() {
        return (List<Wellness_Journey__c>) Database.query(newQueryFactory().toSOQL());
    }

    public Database.QueryLocator queryLocatorSelectCompletedByDateRange(Date startDate, Date endDate) {
        return Database.getQueryLocator(newQueryFactory()
        .selectField('Owner.Name')
        .selectField('Owner.Email')
        .selectField('Owner.Username')
        .setCondition('Status__c = \'Complete\'')
        .setCondition('Completion_Date__c >= :startDate')
        .setCondition('Completion_Date__c <= :endDate')
        .setCondition('isUser__c = true') 
        .setCondition('isGroup__c = false') 
        .addOrdering('OwnerId, Completion_Date__c',fflib_QueryFactory.SortOrder.DESCENDING, true).toSOQL());
    }

    public List<Wellness_Journey__c> selectCompletedByDateRange(Date startDate, Date endDate) {
        fflib_QueryFactory queryFactory = newQueryFactory()
            .selectField('Owner.Name')
            .selectField('Owner.Email')
            .selectField('Owner.Username')
            .setCondition('Status__c = \'Complete\'')
            .setCondition('Completion_Date__c >= :startDate')
            .setCondition('Completion_Date__c <= :endDate')
            .setCondition('isUser__c = true')
            .setCondition('isGroup__c = false')  
            .addOrdering('OwnerId, Completion_Date__c',fflib_QueryFactory.SortOrder.DESCENDING, true);
        return Database.query(queryFactory.toSOQL());
    }
}