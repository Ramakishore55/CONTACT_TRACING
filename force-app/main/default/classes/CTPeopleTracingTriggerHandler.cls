public with sharing class CTPeopleTracingTriggerHandler {
    public static void beforeInsert(List<People_Tracing__c> newRecords) {

        List<People_Tracing__c> duplicateTraces= CTPeopleTracingController.checkDuplicates(newRecords);
        if(duplicateTraces.size()>0 && duplicateTraces != null){
            for(People_Tracing__c dups : duplicateTraces ){
                dups.addError('Duplicate Person1'+ dups.Person_1__c +'Duplicate Person2'+ dups.Person_2__c);
            }
        }
    }
}