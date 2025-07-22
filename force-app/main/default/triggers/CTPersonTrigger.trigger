trigger CTPersonTrigger on Person__c 
(before insert,before update,before delete,after insert,after update,after delete,after undelete) 
{
    switch on Trigger.operationType{
        when BEFORE_INSERT {
            //Helath status-Green-Before Insertion
            //create a list of person records to update
            //List<Person__c> PersonRecordsToInsert = new List<Person__c>();
           CTPersonTriggerHandler.beforeInsert(Trigger.New);
                /*if(Person.Health_Status__c != Trigger.oldMap.get(person.Id).Health_Status__c){
                    person.Status_Update_Date__c = Date.Today();
                }*/
                
                

            }
            when BEFORE_UPDATE{
                CTPersonTriggerHandler.beforeUpdate(Trigger.New, Trigger.oldMap);
            }
            when AFTER_UPDATE{
                CTPersonTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
            }
        }
    }