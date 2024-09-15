public class AccessibilityProjectsSelector extends fflib_SObjectSelector implements IAccessibilityProjectsSelector {
    
    public static IAccessibilityProjectsSelector newInstance() {
        return (IAccessibilityProjectsSelector) Application.Selector.newInstance(Accessibility_Project__c.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            Accessibility_Project__c.Id,
            Accessibility_Project__c.Name,
            Accessibility_Project__c.Amount__c,
            Accessibility_Project__c.Status__c,
            Accessibility_Project__c.Type__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Accessibility_Project__c.SObjectType;
    }

    public List<Accessibility_Project__c> selectAll() {
        return (List<Accessibility_Project__c>) Database.query(newQueryFactory().toSOQL());
    }
}