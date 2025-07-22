trigger LeadTrigger on Lead (before insert,before update,after insert,after update,before delete, after delete,after undelete) {
   /*system.debug('Lead trigger created');   
    for(Lead var : Trigger.New){
        if(String.isBlank(var.LeadSource)){
            var.LeadSource='Other';
        }
        -----------------------------------------
Trigger: When a Lead status changes to "Qualified"
Action: Automatically create related Account, Contact, and Opportunity records

    }*/
    switch on Trigger.operationType{
        when AFTER_UPDATE{
            //Create a trigger Handler.
           exLeadTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
        }
    }
    
}