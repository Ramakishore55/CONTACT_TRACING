trigger AccountTrigger on Account (before insert,After Insert, After update) {
    switch on Trigger.operationType{
        when AFTER_INSERT{
            AccountTriggerHandler.afterInsert(Trigger.New);
        }
        when AFTER_UPDATE{
            AccountTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
        }
        
    }

}