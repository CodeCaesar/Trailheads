public class AddPrimaryContact implements Queueable {
  private Contact thisContact;
  private String thisState;
  public AddPrimaryContact(Contact theContact, String theState) {
    this.thisContact = theContact;
    this.thisState = theState;
  }
  public void execute(QueueableContext context) {
    IAccounts theseAccounts = Accounts.newInstance(
      AccountsSelector.newInstance()
        .selectWithContactsByBillingStateLimit(this.thisState, 200)
    );

    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    for (Account thisAcount : theseAccounts.getAccounts()) {
      Contact theContact = this.thisContact.clone();
      theContact.accountId = thisAcount.id;
      theUnitOfWork.registerNew(theContact);
    }
    theUnitOfWork.commitWork();
  }
}
