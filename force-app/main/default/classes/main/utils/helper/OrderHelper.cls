public without sharing class OrderHelper {
    static fflib_ISObjectUnitOfWork theUnitOfWork = Application.UnitOfWork.newInstance();
    /**
     * @name AfterUpdate
     * @description 
     * @param List<Order> newList
     * @param List<Order> oldList
     * @return void
    **/
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        Set<Id> orderIds = new Set<Id>();
        for ( Integer i=0; i<newList.size(); i++ ){
            if ( newList[i].Status.equalsIgnoreCase(Constants.ACTIVATED_ORDER_STATUS) && !oldList[i].Status.equalsIgnoreCase(Constants.ACTIVATED_ORDER_STATUS) ){
                orderIds.add(newList[i].Id);
            }
        }
        RollUpOrderItems(orderIds);
    }

    /**
     * @name RollUpOrderItems
     * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
     * @param Set<Id> activatedOrderIds
     * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        IOrders theseNewOrders = Orders.newInstance(OrdersSelector.newInstance().selectWithOrderItems(activatedOrderIds));
        Map<ID, Product2> productMap = new Map<ID, Product2>();

        for (Order thisOrder : theseNewOrders.getOrders()) {
            for ( OrderItem thisOrderItem : [SELECT Id, Product2Id, Product2.Quantity_Ordered__c, Quantity
                                                                                                FROM OrderItem
                                                                                                WHERE OrderId = :thisOrder.Id]
            ){
                Product2 thisProduct = thisOrderItem.Product2;
                //thisProduct.Quantity_Ordered__c -= thisOrderItem.Quantity;
                productMap.put(thisProduct.id, thisProduct);
                // theUnitOfWork.registerDirty(thisProduct);
            }
            AggregateResult[] groupedOrderItems = [SELECT Product2Id, SUM(Quantity) totalQuantity
                                                    FROM OrderItem
                                                    WHERE Product2Id IN :productMap.keySet()
                                                    GROUP BY Product2Id];
            for (AggregateResult thisAggregateResult : groupedOrderItems){
                Product2 thisProduct = productMap.get((ID)thisAggregateResult.get('Product2Id'));
                thisProduct.Quantity_Ordered__c = (Decimal)thisAggregateResult.get('totalQuantity');
                theUnitOfWork.registerDirty(thisProduct);
            }
        }

        
        theUnitOfWork.commitWork();
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records

        //ToDo: Loop through a query of OrderItems related to the activatedOrderIds

            //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value

        //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset

        //ToDo: Perform an update on the records in the productMap
    }

}