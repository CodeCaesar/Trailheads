public class AccessibilityProjects extends fflib_SObjects implements IAccessibilityProjects {
    private Database.BatchableContext THEBATCHABLECONTEXT;

    public static IAccessibilityProjects newInstance(List<Accessibility_Project__c> recordList) {
        return (IAccessibilityProjects) Application.Domain.newInstance(recordList);
    }

    public static IAccessibilityProjects newInstance(Set<Id> recordIdSet) {
        return (IAccessibilityProjects) Application.Domain.newInstance(recordIdSet);
    }

    public AccessibilityProjects(List<Accessibility_Project__c> sObjectList) {
        super(sObjectList, Schema.Accessibility_Project__c.SObjectType);
    }

    public List<Accessibility_Project__c> getAccessibilityProjects() {
        return (List<Accessibility_Project__c>) getRecords();
    }

    public Map<ID, Accessibility_Project__c> getAccessibilityProjectsMap() {
        return new Map<ID, Accessibility_Project__c>(getAccessibilityProjects());
    }

    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new AccessibilityProjects((List<SObject>) objectList);
        }
    }
}