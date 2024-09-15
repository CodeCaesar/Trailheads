public class WellnessJourneys extends fflib_SObjects implements IWellnessJourneys {

    public static IWellnessJourneys newInstance(List<Wellness_Journey__c> recordList) {
        return (IWellnessJourneys) Application.Domain.newInstance(recordList);
    }

    public static IWellnessJourneys newInstance(Set<Id> recordIdSet) {
        return (IWellnessJourneys) Application.Domain.newInstance(recordIdSet);
    }

    public WellnessJourneys(List<Wellness_Journey__c> sObjectList) {
        super(sObjectList, Schema.Wellness_Journey__c.SObjectType);
    }

    public List<Wellness_Journey__c> getWellnessJourneys() {
        return (List<Wellness_Journey__c>) getRecords();
    }

    public Map<ID, Wellness_Journey__c> getWellnessJourneysMap() {
        return new Map<ID, Wellness_Journey__c>(getWellnessJourneys());
    }

    public List<Map<String, Object>> getCompletedUsersListMap() {
        Map<Id, Integer> userGoalCountMap = new Map<Id, Integer>();
        Set<Id> uniqueUserId = new Set<Id>();
        List<Map<String, Object>> usersListMap = new List<Map<String, Object>>();
        for (Wellness_Journey__c journey : getWellnessJourneys()) {
            userGoalCountMap.put(journey.OwnerId, 0);        
        } 
        for (Wellness_Journey__c journey : getWellnessJourneys()) {
    
            // Calculate the number of journeys completed by each user
            Integer goalCount = userGoalCountMap.get(journey.OwnerId);
            goalCount++;
            userGoalCountMap.put(journey.OwnerId,goalCount);
            if(userGoalCountMap.get(journey.OwnerId)>=12 && !uniqueUserId.contains(journey.OwnerId)){
            
            Map<String, Object> userObj = new Map<String, Object>();
    
                uniqueUserId.add(journey.OwnerId);
               
                //Build JSON object    
                
                userObj.put('userId',journey.OwnerId);
                userObj.put('fullName',journey.Owner.Name);
                userObj.put('email',journey.Owner.Email);
                userObj.put('username',journey.Owner.Username);
                
                //Add to array
                usersListMap.add(userObj);
            }
        }
        return usersListMap;
    }

    public String serializeCompletedUsersList() {
        List<Map<String, Object>> usersListMap = getCompletedUsersListMap();
        return JSON.serialize(usersListMap);
    }
        
    


    public class Constructor implements fflib_IDomainConstructor {
        public fflib_SObjects construct(List<Object> objectList) {
            return new WellnessJourneys((List<SObject>) objectList);
        }
    }
}