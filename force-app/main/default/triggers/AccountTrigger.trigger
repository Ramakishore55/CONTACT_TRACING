trigger AccountTrigger on Account (before insert,After Insert) {
    switch on Trigger.operationType{
        when AFTER_INSERT{
            AccountTriggerHandler.afterInsert(Trigger.New);
        }
        
    }

}