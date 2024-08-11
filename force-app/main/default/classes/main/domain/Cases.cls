public class Cases extends fflib_SObjects implements ICases {
  private static Map<ID, List<Equipment_Maintenance_Item__c>> casesEquipmentMaintenanceItemsMap = new Map<ID, List<Equipment_Maintenance_Item__c>>();
  public static ICases newInstance(List<Case> recordList) {
    return (ICases) Application.Domain.newInstance(recordList);
  }

  public static ICases newInstance(Set<Id> recordIdSet) {
    return (ICases) Application.Domain.newInstance(recordIdSet);
  }

  public Cases(List<Case> sObjectList) {
    super(sObjectList, Schema.Case.SObjectType);
  }

  public List<Case> getCases() {
    return (List<Case>) getRecords();
  }

  public Map<ID, Case> getCasesMap() {
    return new Map<ID, Case>(getCases());
  }
  public Map<ID, List<Equipment_Maintenance_Item__c>> getCasesEquipmentMaintenanceItemsMap() {
    if (casesEquipmentMaintenanceItemsMap.values().size() > 0)
      return casesEquipmentMaintenanceItemsMap;
    Map<ID, List<Equipment_Maintenance_Item__c>> casesEquipmentMaintenanceItemsMapTemp = new Map<ID, List<Equipment_Maintenance_Item__c>>();
    for (Case thisCase : getCases()) {
      for (
        Equipment_Maintenance_Item__c thisEquipmentMaintenanceItem : thisCase.Equipment_Maintenance_Items__r
      ) {
        if (casesEquipmentMaintenanceItemsMapTemp.get(thisCase.ID) == null) {
          casesEquipmentMaintenanceItemsMapTemp.put(
            thisCase.ID,
            new List<Equipment_Maintenance_Item__c>{
              thisEquipmentMaintenanceItem
            }
          );
        } else {
          casesEquipmentMaintenanceItemsMapTemp.get(thisCase.ID)
            .add(thisEquipmentMaintenanceItem);
        }
      }
    }
    return casesEquipmentMaintenanceItemsMapTemp;
  }

  public Set<ID> getProductIDSet() {
    Set<ID> ProductIDSet = new Set<ID>();
    for (
      List<Equipment_Maintenance_Item__c> theEquipmentMaintenanceItemList : getCasesEquipmentMaintenanceItemsMap()
        .values()
    ) {
      for (
        Equipment_Maintenance_Item__c theEquipmentMaintenanceItem : theEquipmentMaintenanceItemList
      ) {
        ProductIDSet.add(theEquipmentMaintenanceItem.Equipment__c);
      }
    }

    return ProductIDSet;
  }

  public void generateMaintenanceRequests(
    fflib_ISObjectUnitOfWork theUnitOfWork
  ) {
    casesEquipmentMaintenanceItemsMap = getCasesEquipmentMaintenanceItemsMap();
    Integer counterCase = 0;
    System.debug(getCases().size());
    List<Case> caseCount = new List<Case>();
    for (case existingCase : getCases()) {
      Case newCase = existingCase.Clone(false, false, false, false);
      newCase.ID = null;
      newCase.Date_Due__c = date.today()
        .addDays(calculateMaintenenceCycle(existingCase.ID));
      newCase.type = 'Routine Maintenance';
      newCase.Date_Reported__c = date.today();
      newCase.Subject = 'Hello World';
      newCase.Status = 'New';
      newCase.Vehicle__c = existingCase.Vehicle__c; // Assuming Vehicle__c is the field for the related vehicle
      theUnitOfWork.registerNew(newCase);
      caseCount.add(newCase);

      List<Equipment_Maintenance_Item__c> newEquipmentMaintenanceItems = casesEquipmentMaintenanceItemsMap.get(
        existingCase.ID
      );
      if (newEquipmentMaintenanceItems != null) {
        for (
          Equipment_Maintenance_Item__c equipmentMaintenanceItem : newEquipmentMaintenanceItems
        ) {
          Equipment_Maintenance_Item__c newEquipmentMaintenanceItem = new Equipment_Maintenance_Item__c();

          newEquipmentMaintenanceItem.Equipment__c = equipmentMaintenanceItem.Equipment__c;
          newEquipmentMaintenanceItem.Quantity__c = equipmentMaintenanceItem.Quantity__c;

          newEquipmentMaintenanceItem.ID = null;
          theUnitOfWork.registerNew(
            newEquipmentMaintenanceItem,
            Equipment_Maintenance_Item__c.Maintenance_Request__c,
            newCase
          );
        }
      }

      counterCase++;
      //newCaseList.add(newCase);
    }
    System.debug(caseCount.size());
  }

  public Integer calculateMaintenenceCycle(ID CaseID) {
    List<Equipment_Maintenance_Item__c> EquipmentMaintenanceItemsList = getCasesEquipmentMaintenanceItemsMap()
      .get(CaseID);
    Integer MaintenanceCycleDays = 0;
    if (
      EquipmentMaintenanceItemsList != null &&
      EquipmentMaintenanceItemsList.size() > 1
    ) {
      for (
        Equipment_Maintenance_Item__c theEquipmentMaintenanceItem : EquipmentMaintenanceItemsList
      ) {
        if (MaintenanceCycleDays > 0) {
          if (
            theEquipmentMaintenanceItem.Maintenance_Cycle__c <
            MaintenanceCycleDays
          )
            MaintenanceCycleDays = Integer.valueOf(
              theEquipmentMaintenanceItem.Maintenance_Cycle__c
            );
        } else {
          MaintenanceCycleDays = Integer.valueOf(
            theEquipmentMaintenanceItem.Maintenance_Cycle__c
          );
        }
      }
    }

    return MaintenanceCycleDays;
  }

  // public Map<ID, List<Equipment_Maintenance_Item__c>> getCasesEquipmentMaintenanceItemsMap() {
  //   Map<ID, List<Equipment_Maintenance_Item__c>> casesEquipmentMaintenanceItemsMap = new Map<ID, List<Equipment_Maintenance_Item__c>>();
  //   for (Case thisCase : getCases()) {
  //     for (
  //       Equipment_Maintenance_Item__c thisEquipmentMaintenanceItem : thisCase.Equipment_Maintenance_Items__r
  //     ) {
  //       if (casesEquipmentMaintenanceItemsMap.get(thisCase.ID) == null) {
  //         casesEquipmentMaintenanceItemsMap.put(
  //           thisCase.ID,
  //           new List<Equipment_Maintenance_Item__c>{
  //             thisEquipmentMaintenanceItem
  //           }
  //         );
  //       } else {
  //         casesEquipmentMaintenanceItemsMap.get(thisCase.ID)
  //           .add(thisEquipmentMaintenanceItem);
  //       }
  //     }
  //   }
  //   return casesEquipmentMaintenanceItemsMap;
  // }

  // public Map<ID, Integer> getRoutineMaintenanceScheduleMap() {
  //   Map<ID, Integer> routineMaintenanceScheduleMap = new Map<ID, Integer>();
  //   for (Case thisCase : getCases()) {
  //     List<Integer> MaintenanceCycleList = new List<Integer>();
  //     for (
  //       Equipment_Maintenance_Item__c thisEquipmentMaintenanceItem : thisCase.Equipment_Maintenance_Items__r
  //     ) {
  //       MaintenanceCycleList.add(
  //         thisEquipmentMaintenanceItem.Equipiment__r.Maintenance_Cycle__c
  //       );
  //     }

  //     MaintenanceCycleList.sort();
  //     if (MaintenanceCycleList.size() > 0)
  //       routineMaintenanceScheduleMap.put(thisCase.ID, MaintenanceCycleList[0]);
  //   }
  //   return routineMaintenanceScheduleMap;
  // }

  // public void createNewRoutineMaintenanceRequest(fflib_ISObjectUnitOfWork theUnitOfWork ) {
  //   //IProducts theseProducts = Products.newInstance(ProductsSelector.newInstance().selectWithEquipmentMaintenanceItems(getCasesMap().keySet()));

  //   //Maintenance_Cycle__c
  //   for (Case thisCase : getCases()) {
  //   //   Case newCase = thisCase.clone();
  //   //   newCase.Type = 'Routine Maintenance';
  //   //   newCase.Date_Due__c = Date.today().addDays(theseProducts.getProductsMap().get(thisCase.ProductId).Maintenance_Cycle__c);
  //   //   newCase.Date_Reported__c = Date.today();
  //   //   newCase.Subject = newCase.Type + ' '+String.valueOf(newCase.Date_Due__c);
  //   //   newCase.Origin = thisCase.ID;
  //   //   newCase.Equipment__c = thisCase.Equipment__c;
  //   //   theUnitOfWork.registerNew(newCase);

  //   // }
  // }

  public class Constructor implements fflib_IDomainConstructor {
    public fflib_SObjects construct(List<Object> objectList) {
      return new Cases((List<SObject>) objectList);
    }
  }
}
