public without sharing class ChartHelper {

    @AuraEnabled
    public static List<ChartData> getInventory() {
        List<ChartData> chartDataList = new List<ChartData>();
        AggregateResult[] groupedOrderItems = [
            SELECT Family, SUM(Quantity_Remaining__c) totalQuantity
            FROM Product2
            WHERE Quantity_Remaining__c > 0 AND isActive = true
            GROUP BY Family
        ];
        for (AggregateResult thisAggregateResult : groupedOrderItems) {
            ChartData thisChartData = new ChartData(
                String.valueOf(thisAggregateResult.get('Family')), 
                (Decimal)thisAggregateResult.get('totalQuantity')
            );
            chartDataList.add(thisChartData);
        }
        // ToDo: Perform a calculation that aggregates active Products that have a positive Quantity_Remaining__c
        // And return a list of ChartData
        // Where the name is the Product Family and the Qty is the sum of the Quantity_Remaining__c
        return chartDataList;
    }

    @AuraEnabled
    public static List<ChartData> getProductInventory() {
        List<ChartData> chartDataList = new List<ChartData>();
        AggregateResult[] groupedOrderItems = [
            SELECT Name, SUM(Quantity_Remaining__c) totalQuantity
            FROM Product2
            WHERE Quantity_Remaining__c > 0 AND isActive = true
            GROUP BY Family
        ];
        for (AggregateResult thisAggregateResult : groupedOrderItems) {
            ChartData thisChartData = new ChartData(
                String.valueOf(thisAggregateResult.get('Family')), 
                (Decimal)thisAggregateResult.get('totalQuantity')
            );
            chartDataList.add(thisChartData);
        }
        // ToDo: Perform a calculation that aggregates active Products that have a positive Quantity_Remaining__c
        // And return a list of ChartData
        // Where the name is the Product Family and the Qty is the sum of the Quantity_Remaining__c
        return chartDataList;
    }
    public class ChartData {
        @AuraEnabled
        public String name { get; set; }
        @AuraEnabled
        public Decimal val { get; set; }

        public ChartData(String name, Decimal val) {
            this.name = name;
            this.val = val;
        }
    }
}