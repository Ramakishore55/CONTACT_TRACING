public with sharing class CTPersonTriggerHandler {

    public static void beforeInsert(List<Person__c> newRecords) {
        for (Person__c person : newRecords) {
            person.Health_Status__c = 'Green';
            person.Token__c = CTPersonController.getToken(person.Mobile__c);
        }
    }

    public static void beforeUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldMap) {
        for (Person__c person : newRecords) {
            if (person.Health_Status__c != oldMap.get(person.Id).Health_Status__c) {
                person.Status_Update_Date__c = Date.today();
            }
        }
    }

    public static void afterUpdate(List<Person__c> newRecords, Map<Id, Person__c> oldMap) {
        Set<Id> statusChange = new Set<Id>();
        Set<Id> redStatus = new Set<Id>();

        for (Person__c person : newRecords) {
            if (person.Health_Status__c != oldMap.get(person.Id).Health_Status__c) {
                statusChange.add(person.Id);
            }
            if (person.Health_Status__c == 'Red' && oldMap.get(person.Id).Health_Status__c != 'Red') {
                redStatus.add(person.Id);
            }
        }

        Set<Id> alreadyProcessed = new Set<Id>();
        alreadyProcessed.addAll(redStatus);

        Set<Id> orangeStatus = new Set<Id>();
        Set<Id> yellowStatus = new Set<Id>();
        List<Person__c> personsToUpdate = new List<Person__c>();

        orangeStatus.addAll(CTPersonController.getCohabitants(redStatus, alreadyProcessed));
        Set<Id> primaryContacts = CTPersonController.getPrimaryContacts(redStatus, alreadyProcessed);
        orangeStatus.addAll(primaryContacts);
        yellowStatus.addAll(CTPersonController.getNeighbours(redStatus, alreadyProcessed));
        yellowStatus.addAll(CTPersonController.getSecondaryContacts(primaryContacts, alreadyProcessed));

        for (Id pid : orangeStatus) {
            personsToUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Orange'));
        }
        for (Id pid : yellowStatus) {
            personsToUpdate.add(new Person__c(Id = pid, Health_Status__c = 'Yellow'));
        }

        if (!personsToUpdate.isEmpty()) {
            update personsToUpdate;
        }

        List<Location_Tracing__c> locationTraces = CTLocationTracingController.getLocationsByPersonIds(statusChange);
        if (locationTraces != null && !locationTraces.isEmpty()) {
            Set<Id> locationIds = new Set<Id>();
            for (Location_Tracing__c trace : locationTraces) {
                locationIds.add(trace.Location__c);
            }
            CTLocationController.UpdateRedScore(locationIds);
        }
    }
}