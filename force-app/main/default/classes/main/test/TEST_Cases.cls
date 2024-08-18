@isTest
private class TEST_Cases {
  @isTest
  static void testRoutineMaintenance() {
    ATK.SaveResult vehicleResults = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    ATK.SaveResult productResults = ATK.prepare(Product2.SObjectType, 2)
      .field(Product2.Name)
      .repeat('Tire', 'Motor')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .index('12XU')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    Vehicle__c thisVehcle = (Vehicle__c) vehicleResults.get(
        Vehicle__c.SObjectType,
        0
      )
      .get(0);
    Product2 thisProductTire = (Product2) productResults.get(
        Product2.SObjectType
      )
      .get(0);
    Product2 thisProductMotor = (Product2) productResults.get(
        Product2.SObjectType
      )
      .get(0);

    ATK.SaveResult caseResults = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(thisVehcle.Name)
      .field(Case.Vehicle__c)
      .repeat(thisVehcle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Routine Maintenance')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    Case thisCase = (Case) caseResults.get(Case.SObjectType, 0).get(0);

    // Use ATK.prepare@isTest private class  to set up test data for Equipment_Maintenance_Item__c
    ATK.prepare(Equipment_Maintenance_Item__c.SObjectType, 2)
      .field(Equipment_Maintenance_Item__c.Equipment__c)
      .repeat(thisProductTire.Id, thisProductMotor.Id)
      .field(Equipment_Maintenance_Item__c.Maintenance_Request__c)
      .repeat(thisCase.Id)
      .save();

    // Update the case status
    thisCase.Status = 'Closed';
    update thisCase;

    List<Case> newMaintRequestList = [
      SELECT Id
      FROM Case
      WHERE
        Type = 'Routine Maintenance'
        AND Status != 'Closed'
        AND Vehicle__c = :thisVehcle.Id
    ];

    System.assertEquals(
      2,
      [
          SELECT Id, Equipment__c
          FROM Equipment_Maintenance_Item__c
          WHERE Maintenance_Request__c = :newMaintRequestList.get(0).Id
        ]
        .size()
    );
  }
  @isTest
  static void testInspection() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();

    ATK.SaveResult vehicleResults = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    Vehicle__c thisVehicle = (Vehicle__c) vehicleResults.get(
        Vehicle__c.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult productSaveResult = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Tires')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .index('12XU')
      .field(Product2.IsActive)
      .repeat(true)
      .save();

    Product2 thisProductTire = (Product2) productSaveResult.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult caseResults = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(thisVehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(thisVehicle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Inspection')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    Case thisCase = (Case) caseResults.get(Case.SObjectType, 0).get(0);

    thisCase.Status = 'Closed';
    theUnitOfWork.registerDirty(thisCase);
    theUnitOfWork.commitWork();

    System.assertEquals(
      1,
      [
          SELECT ID
          FROM Case
          WHERE subject LIKE '%Freebird%' AND Status = 'Closed'
        ]
        .size()
    );
    System.assertEquals(
      0,
      [
          SELECT ID
          FROM Case
          WHERE
            Type = 'Routine Maintenance'
            AND Status != 'Closed'
            AND Vehicle__c = :thisVehicle.Id
        ]
        .size()
    );
  }
  @isTest
  static void testDate() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    ATK.SaveResult vehicleResults = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    // Retrieve the inserted vehicle using ATK.SaveResult
    Vehicle__c thisVehicle = (Vehicle__c) vehicleResults.get(
        vehicle__c.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult productResults = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Tires')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .index('12XU')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    Product2 thisProductTires = (Product2) productResults.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult productMotorResults = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Motor')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(15)
      .field(Product2.Warehouse_SKU__c)
      .repeat('13XU')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    Product2 thisProductMotor = (Product2) productMotorResults.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult caseResults = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(thisVehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(thisVehicle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Routine Maintenance')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    Case thisCase = (Case) caseResults.get(Case.SObjectType, 0).get(0);

    ATK.SaveResult equipmentMaintenanceItemResults = ATK.prepare(
        Equipment_Maintenance_Item__c.SObjectType,
        2
      )
      .field(Equipment_Maintenance_Item__c.Equipment__c)
      .repeat(
        String.valueOf(thisProductTires.Id),
        String.valueOf(thisProductMotor.Id)
      )
      .field(Equipment_Maintenance_Item__c.Maintenance_Request__c)
      .repeat(thisCase.Id)
      .save();

    thisCase.Status = 'Closed';
    theUnitOfWork.registerDirty(thisCase);
    theUnitOfWork.commitWork();

    System.assertEquals(
      Date.Today().addDays(15),
      [
        SELECT Id, Date_Due__c
        FROM Case
        WHERE
          Type = 'Routine Maintenance'
          AND Status != 'Closed'
          AND Vehicle__c = :thisVehicle.Id
      ][0]
      .Date_Due__c
    );
  }
  @isTest
  static void testBulkAnotherCaseUpdate() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    ATK.SaveResult vehicleResults = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    // Retrieve the inserted vehicle using ATK.SaveResult
    Vehicle__c thisVehicle = (Vehicle__c) vehicleResults.get(
        vehicle__c.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult productResults = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Tires')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .index('12XU')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    Product2 thisProductTires = (Product2) productResults.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    ATK.SaveResult caseResults = ATK.prepare(Case.SObjectType, 201)
      .field(Case.Subject)
      .index(thisVehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(thisVehicle.ID)
      .field(Case.Status)
      .repeat('New')
      .field(Case.Type)
      .repeat('Routine Maintenance', 'Repair')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .withChildren(
        Equipment_Maintenance_Item__c.SObjectType,
        Equipment_Maintenance_Item__c.Maintenance_Request__c,
        1
      )
      .field(Equipment_Maintenance_Item__c.Equipment__c)
      .repeat(thisProductTires.ID)
      .save();

    // update all of the work orders as closed -- should create 200 more
    for (Case thisCase : (List<Case>) caseResults.get(Case.SObjectType, 0)) {
      thisCase.Status = 'Closed';
      theUnitOfWork.registerDirty(thisCase);
    }
    theUnitOfWork.commitWork();

    System.assertEquals(
      401,
      [SELECT COUNT() FROM Case WHERE Vehicle__c = :thisVehicle.Id]
    );
  }
}
