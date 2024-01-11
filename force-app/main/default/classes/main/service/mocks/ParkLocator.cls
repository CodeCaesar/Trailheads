public with sharing class ParkLocator {
  public static List<String> country(String theCountry) {
    ParkService.ParksImplPort theParkService = new ParkService.ParksImplPort();
    return theParkService.byCountry(theCountry);
  }
}
