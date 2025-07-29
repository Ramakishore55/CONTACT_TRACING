trigger OpportunityTrigger on Opportunity (before insert,after insert,after update) {

    switch on Trigger.operationType{
        when AFTER_INSERT{
            OpportunityTriggerHandler.afterInsert(Trigger.New);
        }
        when AFTER_UPDATE{
            OpportunityTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
        }
    }

}