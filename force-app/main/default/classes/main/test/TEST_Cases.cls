@isTest
private class TEST_Cases {
  @isTest
  static void testRoutineMaintenance() {
    // Initialize counters
    Integer totalClosedCount = 0;
    Integer totalOpenCount = 0;
    Savepoint startPoint = Database.setSavepoint();

    // Use ATK.prepare to set up test data for Vehicle and Product2
    ATK.SaveResult vehicleSaveResult = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    ATK.SaveResult productSaveResult = ATK.prepare(Product2.SObjectType, 2)
      .field(Product2.Name)
      .repeat('Toilet Seat Cover', 'Motor')
      .field(Product2.Cost__c)
      .repeat(100, 100)
      .field(Product2.Current_Inventory__c)
      .repeat(1, 1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1, 1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30, 15)
      .field(Product2.Warehouse_SKU__c)
      .repeat('#grubsareyummy', '#grubsareyummy')
      .field(Product2.IsActive)
      .repeat(true, true)
      .field(Product2.Replacement_Part__c)
      .repeat(true, true)
      .save();

    // Retrieve the inserted records using ATK.SaveResult
    Vehicle__c vehicle = (Vehicle__c) vehicleSaveResult.get(
        Vehicle__c.SObjectType,
        0
      )
      .get(0);
    Product2 equipment1 = (Product2) productSaveResult.get(Product2.SObjectType)
      .get(0);
    Product2 equipment2 = (Product2) productSaveResult.get(Product2.SObjectType)
      .get(0);

    // Use ATK.prepare to set up test data for Case
    ATK.SaveResult caseSaveResult = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(vehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(vehicle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Routine Maintenance')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    // Retrieve the inserted case using ATK.SaveResult
    Case maintenanceRequest = (Case) caseSaveResult.get(Case.SObjectType, 0)
      .get(0);

    // Use ATK.prepare@isTest private class  to set up test data for Equipment_Maintenance_Item__c
    ATK.prepare(Equipment_Maintenance_Item__c.SObjectType, 2)
      .field(Equipment_Maintenance_Item__c.Equipment__c)
      .repeat(equipment1.Id, equipment2.Id)
      .field(Equipment_Maintenance_Item__c.Maintenance_Request__c)
      .repeat(maintenanceRequest.Id, maintenanceRequest.Id)
      .save();

    // Update the case status
    maintenanceRequest.Status = 'Closed';
    update maintenanceRequest;

    List<Case> newMaintRequestCreated = [
      SELECT Id
      FROM Case
      WHERE
        Type = 'Routine Maintenance'
        AND Status != 'Closed'
        AND Vehicle__c = :vehicle.Id
    ];
    List<Equipment_Maintenance_Item__c> equipMaintItems = new List<Equipment_Maintenance_Item__c>();
    if (newMaintRequestCreated.size() > 0) {
      equipMaintItems = [
        SELECT Id, Equipment__c
        FROM Equipment_Maintenance_Item__c
        WHERE Maintenance_Request__c = :newMaintRequestCreated.get(0).Id
      ];
    }
    // clean up, rolling back the savepoint.
    Database.rollback(startPoint);

    System.assertEquals(2, equipMaintItems.size());
  }
  @isTest
  static void testInspection() {
    Integer totalClosedCount = 0;
    Integer totalOpenCount = 0;

    // Creates the savepoint
    Savepoint startPoint = Database.setSavepoint();

    // Create a Unit of Work instance
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();

    // Use ATK.prepare to set up test data for Vehicle
    ATK.SaveResult vehicleSaveResult = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    // Retrieve the inserted vehicle using ATK.SaveResult
    Vehicle__c vehicle = (Vehicle__c) vehicleSaveResult.get(
        Vehicle__c.SObjectType,
        0
      )
      .get(0);

    // Use ATK.prepare to set up test data for Product2
    ATK.SaveResult productSaveResult = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Toilet Seat Cover')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .repeat('#grubsareyummy')
      .field(Product2.IsActive)
      .repeat(true)
      .save();

    // Retrieve the inserted equipment using ATK.SaveResult
    Product2 equipment = (Product2) productSaveResult.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    // Use ATK.prepare to set up test data for Case
    ATK.SaveResult caseSaveResult = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(vehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(vehicle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Inspection')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    // Retrieve the inserted case using ATK.SaveResult
    Case c2 = (Case) caseSaveResult.get(Case.SObjectType, 0).get(0);

    // Register the case for update with the Unit of Work
    c2.Status = 'Closed';
    theUnitOfWork.registerDirty(c2);

    // Commit the Unit of Work to perform the DML operations
    theUnitOfWork.commitWork();

    // Grab some values so we can compare after clean up
    totalClosedCount = [
      SELECT COUNT()
      FROM Case
      WHERE subject LIKE '%Freebird%' AND Status = 'Closed'
    ];
    totalOpenCount = [
      SELECT COUNT()
      FROM Case
      WHERE
        Type = 'Routine Maintenance'
        AND Status != 'Closed'
        AND Vehicle__c = :vehicle.Id
    ];

    // Clean up, rolling back the savepoint
    Database.rollback(startPoint);

    System.assertEquals(1, totalClosedCount);
    System.assertEquals(0, totalOpenCount);
  }
  @isTest
  static void testDate() {
    Integer totalClosedCount = 0;
    Integer totalOpenCount = 0;

    // Creates the savepoint
    Savepoint startPoint = Database.setSavepoint();

    // Use ATK.prepare to set up test data for Vehicle__c
    ATK.SaveResult vehicleSaveResult = ATK.prepare(Vehicle__c.SObjectType, 1)
      .field(Vehicle__c.Name)
      .index('Freebird')
      .save();

    // Retrieve the inserted vehicle using ATK.SaveResult
    Vehicle__c vehicle = (Vehicle__c) vehicleSaveResult.get(
        vehicle__c.SObjectType,
        0
      )
      .get(0);

    // Use ATK.prepare to set up test data for Product2 (equipment1)
    ATK.SaveResult productSaveResult1 = ATK.prepare(Product2.SObjectType, 1)
      .field(Product2.Name)
      .index('Toilet Seat Cover')
      .field(Product2.Cost__c)
      .repeat(100)
      .field(Product2.Current_Inventory__c)
      .repeat(1)
      .field(Product2.Lifespan_Months__c)
      .repeat(1)
      .field(Product2.Maintenance_Cycle__c)
      .repeat(30)
      .field(Product2.Warehouse_SKU__c)
      .repeat('#grubsareyummy')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    // Retrieve the inserted equipment1 using ATK.SaveResult
    Product2 equipment1 = (Product2) productSaveResult1.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    // Use ATK.prepare to set up test data for Product2 (equipment2)
    ATK.SaveResult productSaveResult2 = ATK.prepare(Product2.SObjectType, 1)
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
      .repeat('#grubsareyummy')
      .field(Product2.IsActive)
      .repeat(true)
      .field(Product2.Replacement_Part__c)
      .repeat(true)
      .save();

    // Retrieve the inserted equipment2 using ATK.SaveResult
    Product2 equipment2 = (Product2) productSaveResult2.get(
        Product2.SObjectType,
        0
      )
      .get(0);

    // Use ATK.prepare to set up test data for Case (maintenance request)
    ATK.SaveResult caseSaveResult = ATK.prepare(Case.SObjectType, 1)
      .field(Case.Subject)
      .index(vehicle.Name)
      .field(Case.Vehicle__c)
      .repeat(vehicle.Id)
      .field(Case.Status)
      .repeat('Open')
      .field(Case.Type)
      .repeat('Routine Maintenance')
      .field(Case.Date_Reported__c)
      .repeat(System.today())
      .save();

    // Retrieve the inserted maintenance request using ATK.SaveResult
    Case maintenanceRequest = (Case) caseSaveResult.get(Case.SObjectType, 0)
      .get(0);

    // Use ATK.prepare to set up test data for Equipment_Maintenance_Item__c
    ATK.SaveResult equipmentMaintenanceItemSaveResult = ATK.prepare(
        Equipment_Maintenance_Item__c.SObjectType,
        2
      )
      .field(Equipment_Maintenance_Item__c.Equipment__c)
      .repeat(String.valueOf(equipment1.Id), String.valueOf(equipment2.Id))
      .field(Equipment_Maintenance_Item__c.Maintenance_Request__c)
      .repeat(maintenanceRequest.Id)
      .save();

    // Update the case status and save it
    maintenanceRequest.Status = 'Closed';
    update maintenanceRequest;

    // Grab some values so we can compare after clean up
    List<Case> newMaintRequestCreated = [
      SELECT Id, Date_Due__c
      FROM Case
      WHERE
        Type = 'Routine Maintenance'
        AND Status != 'Closed'
        AND Vehicle__c = :vehicle.Id
    ];

    // Clean up, rolling back the savepoint
    Database.rollback(startPoint);

    System.assertEquals(
      Date.Today().addDays(15),
      newMaintRequestCreated.get(0).Date_Due__c
    );
  }
  @isTest
  static void testBulkAnotherCaseUpdate() {
    Savepoint startPoint = Database.setSavepoint();
    Vehicle__c vehicle = new Vehicle__c(Name = '1984 AMC Spirit Coupe');
    insert vehicle;

    // create a new product2/equipment
    Product2 equipment = new Product2();
    equipment.Name = 'Astro Cup Holder';
    equipment.Cost__c = 100;
    equipment.Current_Inventory__c = 1;
    equipment.Lifespan_Months__c = 1;
    equipment.Maintenance_Cycle__c = 30;
    equipment.Warehouse_SKU__c = '#holdthis';
    equipment.IsActive = true;
    equipment.Replacement_Part__c = true;
    insert equipment;

    // INSERT 201 work orders as open with routine maintenance
    List<Case> cases = new List<Case>();
    for (Integer i = 0; i < 201; i++) {
      Case c = new Case();
      c.Subject = vehicle.Name;
      c.Vehicle__c = vehicle.Id;
      c.Status = 'New';
      c.Type = 'Routine Maintenance';
      c.Date_Reported__c = System.today();
      cases.add(c);
    }
    insert cases;

    List<Equipment_Maintenance_Item__c> equipmentMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
    for (Case curr : cases) {
      equipmentMaintenanceItems.add(
        new Equipment_Maintenance_Item__c(
          Equipment__c = equipment.Id,
          Maintenance_Request__c = curr.Id
        )
      );
    }
    insert equipmentMaintenanceItems;

    // update all of the work orders as closed -- should create 200 more
    for (Case c : cases) {
      c.Status = 'Closed';
    }
    System.debug(cases.size());
    System.debug(new Map<ID, Case>(cases).keySet().size());
    update cases;

    System.assertEquals(
      402,
      [SELECT COUNT() FROM Case WHERE Vehicle__c = :vehicle.Id]
    );
    Database.rollback(startPoint);
  }
}
