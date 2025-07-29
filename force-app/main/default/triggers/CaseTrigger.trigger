trigger CaseTrigger on Case (before insert, after Insert) {
    switch on Trigger.operationType{
        when AFTER_INSERT{
            CaseTriggerHandler.afterInsert(Trigger.New);
        }
    }

}