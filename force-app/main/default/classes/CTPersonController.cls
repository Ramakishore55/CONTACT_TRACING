/**
 * CTPersonController
 * Main controller class for Person__c object
 * @author Manish
 */
public with sharing class CTPersonController {

    /**
     * generate unique token using mobile number
     * use MD5 algorithm to generate one-way hash
     * @param mobile
     * @return string token
     */
    public static String getToken(String mobileNo){
        Blob value = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', value);
        // return encoded string
        return EncodingUtil.base64Encode(hash);
    }
    public static set<Id> getCohabitants(set<Id> personIds,set<Id> alreadyProcessed) {
        List<String> healthStatuses= new list<String>{'Green','Yellow'};
        List<People_Tracing__c> peopleTraces= [Select Id, Person_1__c,Person_2__c from People_Tracing__c 
        where (Person_1__c In :personIds OR Person_2__c In:personIds) AND Contact_Type__c='Cohabitant'
         AND (Person_1__r.Health_Status__c In:healthStatuses OR Person_2__r.Health_Status__c In : healthStatuses)];
         set<Id> cohabitants = new set<Id>();
         for (People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                cohabitants.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);

            }
            if(!personIds.contains(pt.Person_2__c)){
                cohabitants.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }

         }
         return cohabitants;
    }
    public static set<Id> getNeighbours(set<Id> personIds,set<Id> alreadyProcessed){
        
        List<People_Tracing__c> peopleTraces= [Select Id, Person_1__c,Person_2__c from People_Tracing__c 
        where (Person_1__c In :personIds OR Person_2__c In:personIds) AND Contact_Type__c='Neighbour'
         AND (Person_1__r.Health_Status__c ='Green' OR Person_2__r.Health_Status__c ='Green')];
         set<Id> Neighbour = new set<Id>();
         for (People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                Neighbour.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                Neighbour.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);

            }

         }
         return Neighbour;
    }
    public static set<Id> getPrimaryContacts(set<Id> personIds,set<Id> alreadyProcessed){
        List<String> healthStatuses= new List<String>{'Green','Yellow'};
        List<People_Tracing__c> peopleTraces= [Select Id,Person_1__c,Person_2__c from People_Tracing__c 
        where( Person_1__c In :personIds OR Person_2__c In:personIds) AND Contact_Type__c='Other'
        AND Contact_Date__c = LAST_N_DAYS:10
         AND (Person_1__r.Health_Status__c In:healthStatuses OR Person_2__r.Health_Status__c In:healthStatuses)];
         set<Id> PrimaryContacts = new set<Id>();
         for (People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                PrimaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                PrimaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }

         }
         return PrimaryContacts;
    }
    public static set<Id> getSecondaryContacts(set<Id> PrimaryContacts,set<Id> alreadyProcessed){
        
        List<People_Tracing__c> peopleTraces= [Select Id, Person_1__c,Person_2__c from People_Tracing__c 
        where (Person_1__c In :PrimaryContacts OR Person_2__c In:PrimaryContacts) AND Contact_Type__c='Other'
         AND (Person_1__r.Health_Status__c ='Green' OR Person_2__r.Health_Status__c ='Green')];
         set<Id> secondaryContacts = new set<Id>();
         for (People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                secondaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                secondaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }

         }
         return secondaryContacts;
    }

}