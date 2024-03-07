global class UpdateBookingStatusScheduler implements Schedulable{
	    global void execute(SchedulableContext sc) {
        
        // Get the current date
		Date currentDate = Date.today();
        // Get the current time
		Time currentTime = Time.newInstance(System.now().hour(), System.now().minute(), System.now().second(), System.now().millisecond());

        
       	// Query for booking records where the date and end time match the current system datetime
		List<Booking__c> bookingsToUpdate = [SELECT Id FROM Booking__c WHERE Date__c = :currentDate AND End_Time__c <= :currentTime];

        // Update the status of matching booking records to "Over"
        List<Booking__c> bookingsToUpdateStatus = new List<Booking__c>();
        for (Booking__c booking : bookingsToUpdate) {
            booking.Status__c = 'Over';
            bookingsToUpdateStatus.add(booking);
        }
        update bookingsToUpdateStatus;
    }
}