public class WarrantiesSelector extends fflib_SObjectSelector implements IWarrantiesSelector {
    
    public static IWarrantiesSelector newInstance() {
        return (IWarrantiesSelector) Application.Selector.newInstance(Warranty__c.SObjectType);
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            Warranty__c.Id,
            Warranty__c.Name,
            Warranty__c.Asset__c,
            Warranty__c.End_Date__c,
            Warranty__c.Start_Date__c,
            Warranty__c.Type__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Warranty__c.SObjectType;
    }

    public List<Warranty__c> selectAll() {
        return (List<Warranty__c>) Database.query(newQueryFactory().toSOQL());
    }

}