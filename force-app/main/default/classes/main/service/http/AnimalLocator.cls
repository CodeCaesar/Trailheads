public with sharing class AnimalLocator {
  public static String getAnimalNameById(Integer animalNumber) {
    Http http = new Http();

    HttpRequest thisRequest = new HttpRequest();
    thisRequest.setEndpoint(
      'https://th-apex-http-callout.herokuapp.com/animals/' + animalNumber
    );
    thisRequest.setMethod('GET');

    HttpResponse thisResponse = http.send(thisRequest);
    Animals thisResult = (Animals) JSON.deserialize(
      thisResponse.getBody(),
      Animals.class
    );
    return thisResult.animal.name;
  }
}
