/**
 * CTLocationController
 * Main controller class for Location__c object
 * @author Manish
 */
public with sharing class CTLocationController {
    Public static void UpdateRedScore(set<Id> locationIds){
        List<Location__c> locationToUpdate = new List<location__c>();
        AggregateResult[] redPeopleLocation = [SELECT Location__c, COUNT(Id)total from Location_Tracing__c
                                                where Person__r.Health_Status__c ='Red'
                                                AND Visit_Date__c = LAST_N_DAYS:10
                                                AND Location__c IN : locationIds
                                                GROUP BY Location__c ];
                    for (AggregateResult ar:redPeopleLocation ){
                        String locationId = (String)(ar.get('Location__c'));
                        Integer redScore = (Integer)(ar.get('total'));
                        String status = getStatus(redScore);
                        locationToUpdate.add(new Location__c(Id =locationId,Red_Score__c=redScore,Status__c=status));
                    }
                    if(locationToUpdate!=null &&locationToUpdate.size()>0){
                        update locationToUpdate;
                    }
    }    
    Public static String getStatus(Integer redScore){
                        if (redScore==0){
                            return 'Green';
                        }else if(redScore<=5){
                            return 'yellow';
                        }else if(redScore<=10){
                            return 'Orange';
                        }else{
                            return 'Red';
                        }
                    }
                

    }