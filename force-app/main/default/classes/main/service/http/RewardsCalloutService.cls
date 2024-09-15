public class RewardsCalloutService{

    public static Integer submitUsersForRewardCallout(String jsonBody) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:IntegrationSB__BalancedLiving/rewards'); 
        request.setMethod('POST');
        request.setBody(jsonBody);
        HttpResponse response = new Http().send(request);
        return response.getStatusCode();
    }
}