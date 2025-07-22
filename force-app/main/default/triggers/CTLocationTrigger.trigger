trigger CTLocationTrigger on Location__c(before insert,after insert,before update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            CTLocationTriggerHandler.beforeInsert(Trigger.New);
            
        }
        when BEFORE_UPDATE {

            CTLocationTriggerHandler.beforeUpdate(Trigger.New,Trigger.oldMap);
        }
        when AFTER_UPDATE {

            CTLocationTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
        }
    }

}