public class VehiclesSelector extends fflib_SObjectSelector implements IVehiclesSelector {
  public static IVehiclesSelector newInstance() {
    return (IVehiclesSelector) Application.Selector.newInstance(
      Vehicle__c.SObjectType
    );
  }

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField>{
      Vehicle__c.Id,
      Vehicle__c.Air_Conditioner__c,
      Vehicle__c.Awning__c,
      Vehicle__c.Backup_Camera_Monitor__c,
      Vehicle__c.Bathroom_Hookup__c,
      Vehicle__c.Bathrooms__c,
      Vehicle__c.Bedrooms__c,
      Vehicle__c.Fancy_Sound_System__c,
      Vehicle__c.Levelers__c,
      Vehicle__c.License_Plate__c,
      Vehicle__c.Make__c,
      Vehicle__c.Model__c,
      Vehicle__c.Power__c,
      Vehicle__c.Propane_Tank__c,
      Vehicle__c.Recommended_Passengers__c,
      Vehicle__c.Roof_Mounted_Antenna__c,
      Vehicle__c.Shower__c,
      Vehicle__c.Tub__c,
      Vehicle__c.Type__c,
      Vehicle__c.Name,
      Vehicle__c.VIN_Number__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Vehicle__c.SObjectType;
  }

  public List<Vehicle__c> selectAll() {
    return (List<Vehicle__c>) Database.query(newQueryFactory().toSOQL());
  }

  public Database.QueryLocator queryLocatorSelectAll() {
    return Database.getQueryLocator(newQueryFactory().toSOQL());
  }
}