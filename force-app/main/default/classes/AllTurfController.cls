public without sharing class AllTurfController {
    
    @AuraEnabled(cacheable=true)
    public static Object getAllTurfs(){
        try {
            return [SELECT Address__c, Area_in_metre_square__c, CreatedById, CreatedDate, Email__c, Id, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Name, OwnerId, Phone__c, Turf_Photo1__c, Price_per_hour__c, SystemModstamp
            FROM Turf__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Object searchForTurf(Map<String,Object> param ){
        try {
            Date searchDate = Date.valueOf((String) param.get('searchDate'));
            Time searchStartTime = updateTime(((String) param.get('searchStartTime'))) ;
            Time searchEndTime = updateTime(((String) param.get('searchEndTime'))) ;


            List<Booking__c> bookings = [SELECT Id, Turf__c, Turf__r.Name, Start_Time__c, End_Time__c, Date__c FROM Booking__c WHERE Date__c = :searchDate  AND ((End_Time__c > :searchStartTime) OR (Start_Time__c > :searchEndTime))];
            
            Set<Id> turfIdSet = new Set<Id>();
            for (Booking__c eachBooking : bookings) {
                turfIdSet.add(eachBooking.Turf__c);
            }

            List<Turf__c> turfRecs = [SELECT Address__c,Turf_Photo1__c, Area_in_metre_square__c, CreatedById, CreatedDate, Email__c, Id, IsDeleted, LastActivityDate, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, Name, OwnerId, Phone__c, Price_per_hour__c, SystemModstamp
            FROM Turf__c WHERE Id NOT IN :turfIdSet];

            System.debug(JSON.serializePretty(turfRecs));

            return turfRecs;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static Time updateTime(String strTimeChange){

        String[] strTimeSplit = strTimeChange.split(':');
        Time timeChange = Time.newInstance( Integer.valueOf(strTimeSplit[0]) //hour
                                           ,Integer.valueOf(strTimeSplit[1]) //min
                                           ,0                                //sec
                                           ,0);  
                                           return timeChange;
    }
}