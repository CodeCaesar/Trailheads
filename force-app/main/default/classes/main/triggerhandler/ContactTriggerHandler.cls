public inherited sharing class ContactTriggerHandler extends fflib_SObjectDomain {
  public ContactTriggerHandler(List<Opportunity> sObjectList) {
    // Domain classes are initialised with lists to enforce bulkification throughout
    super(sObjectList);
  }

  public override void onBeforeInsert() {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    IContacts theseContacts = Contacts.newInstance((List<Contact>) Records);
    theUnitOfWork.commitWork();
  }

  public override void onBeforeUpdate(Map<Id, SObject> existingContactMap) {
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();

    IContacts theseContacts = Contacts.newInstance(
      (List<Contact>) this.records
    );
    theUnitOfWork.commitWork();
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new ContactTriggerHandler(sObjectList);
    }
  }
}
