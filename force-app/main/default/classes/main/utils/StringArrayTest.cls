public with sharing class StringArrayTest {
  public static List<String> generateStringArray(Integer numberOfStrings) {
    List<String> theStringList = new List<String>();
    for (Integer counter = 0; counter < numberOfStrings; counter++) {
      String theString = 'Test ' + counter;
      theStringList.add(theString);
    }
    return theStringList;
  }
}
