public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
  private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
  public static void execute(QueueableContext context) {
    Http http = new Http();
    HttpRequest thisRequest = new HttpRequest();
    thisRequest.setEndpoint(WAREHOUSE_URL);
    thisRequest.setMethod('GET');

    HttpResponse thisResponse = http.send(thisRequest);
    fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    if (thisResponse.getStatusCode() == 200) {
      List<WarehouseCalloutServiceJSON> jsonList = WarehouseCalloutServiceJSON.parse(
        thisResponse.getBody()
      );
      List<Product2> newProductsList = new List<Product2>();
      for (
        WarehouseCalloutServiceJSON thisWarehouseCalloutServiceJSON : jsonList
      ) {
        Product2 product = new Product2();
        product.Name = thisWarehouseCalloutServiceJSON.name;
        // product.Description = thisWarehouseCalloutServiceJSON.Description;
        product.Replacement_Part__c = thisWarehouseCalloutServiceJSON.replacement;
        product.ExternalId = thisWarehouseCalloutServiceJSON.x_id;
        product.Lifespan_Months__c = thisWarehouseCalloutServiceJSON.lifespan;
        product.Cost__c = thisWarehouseCalloutServiceJSON.cost;
        product.Warehouse_SKU__c = thisWarehouseCalloutServiceJSON.sku;
        product.Maintenance_Cycle__c = thisWarehouseCalloutServiceJSON.maintenanceperiod;
        newProductsList.add(product);
      }
      Database.upsert(newProductsList, Product2.Warehouse_SKU__c);
    }
  }
}

// public static String getAnimalNameById(Integer animalNumber) {
//     Http http = new Http();

//     HttpRequest thisRequest = new HttpRequest();
//     thisRequest.setEndpoint(
//       'https://th-apex-http-callout.herokuapp.com/animals/' + animalNumber
//     );
//     thisRequest.setMethod('GET');

//     HttpResponse thisResponse = http.send(thisRequest);
//     Animals thisResult = (Animals) JSON.deserialize(
//       thisResponse.getBody(),
//       Animals.class
//     );
//     return thisResult.animal.name;
//   }

