/*trigger ContactTrigger on Contact (after insert,after update) {
    // Step 1: Collect AccountIds from Trigger.New
    Set<Id> accountIds = new Set<Id>();
    for (Contact c : Trigger.New) {
        if (c.AccountId != null && c.Active__c == true) {
            accountIds.add(c.AccountId);
        }
    }

    // Step 2: Query active contacts related to those AccountIds
    List<Contact> activeContacts = [
        SELECT AccountId, Active__c 
        FROM Contact 
        WHERE AccountId IN :accountIds AND Active__c = true
    ];

    // Step 3: Build Map<Id, List<Contact>>
    Map<Id, List<Contact>> contactMap = new Map<Id, List<Contact>>();
    for (Contact c : activeContacts) {
        if (!contactMap.containsKey(c.AccountId)) {
            contactMap.put(c.AccountId, new List<Contact>());
        }
        contactMap.get(c.AccountId).add(c);
    }

    // Step 4: Query Accounts and update Active_Contacts__c
    List<Account> accountsToUpdate = [
        SELECT Id, Active_Contacts__c 
        FROM Account 
        WHERE Id IN :accountIds
    ];

    for (Account acc : accountsToUpdate) {
        if (contactMap.containsKey(acc.Id)) {
            acc.Active_Contacts__c = contactMap.get(acc.Id).size();
        } else {
            acc.Active_Contacts__c = 0;
        }
    }

    update accountsToUpdate;
}-----------------------------------------------------------------------------------------------*/
trigger ContactTrigger on Contact(after insert, after update, after delete, after undelete,before Insert) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.afterInsertHandler(Trigger.new);
        }
        when AFTER_UPDATE {
            ContactTriggerHandler.afterUpdateHandler(Trigger.new, Trigger.oldMap);
        }
        when AFTER_DELETE {
            ContactTriggerHandler.afterDeleteHandler(Trigger.old);
        }
        when AFTER_UNDELETE {
            ContactTriggerHandler.afterUnDeleteHandler(Trigger.new);
        }
        when BEFORE_INSERT{
            //Call Handler class here.
            ContactTriggerHandler.beforeInsert(Trigger.new);
        }
    }
}