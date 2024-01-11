public with sharing class ContactAndLeadSearch {
  public static List<List<sObject>> searchContactsAndLeads(
    String searchString
  ) {
    List<List<sObject>> searchList = [
      FIND :searchString
      IN ALL FIELDS
      RETURNING Lead(FirstName, LastName), Contact(FirstName, LastName)
    ];
    return searchList;
  }
}
