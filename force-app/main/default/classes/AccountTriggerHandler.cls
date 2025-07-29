public class AccountTriggerHandler {
    public static void afterInsert(List<Account> InsertedAccounts){
        List<Account> accountsToUpdate = new List<Account>();
        //Action: Fill in a custom field like “Customer Segment” based on Account type or annual revenue
        if(InsertedAccounts!=null){
            for (Account forVar:InsertedAccounts){
                if(forVar.Type!=null ||forVar.AnnualRevenue!=null ){
				Account tempAcc = new Account(Id = forVar.Id);
                   //forVar.Customer_Segment__c=System.now();
                    accountsToUpdate.add(tempAcc);
                }
            }
            
        }
       if(!accountsToUpdate.isEmpty()){
            for(Account forVar:accountsToUpdate){
                forVar.Customer_Segment__c=System.now();
            }    
        }
        update accountsToUpdate;
        
    }
    public static void afterUpdate(List<Account> newaccts,Map<Id,Account> oldMap){
        //	• Trigger: When an Account name changes
        // Action: Update related Contacts' "Account Name" field to match
        //1)


        List<Contact> ctsToUpdate = new List<Contact>();
        set<Id> commonIds = new set<Id>();
        Map<Id, String> newAccountNames = new Map<Id, String>();
        for(Account forVar:newaccts){
            if(forVar.Name!=oldMap.get(forVar.Id).Name){
                commonIds.add(forVar.Id);
              // Contact cts= new Contact(AccountId=forVar.Id, LastName=forVar.Name);
              // ctsToUpdate.add(cts);
              newAccountNames.put(forVar.Id,forVar.Name);
            }
           
           
        }
        ctsToUpdate.addAll([select Id, AccountId,Name,LastName from Contact where AccountId In :commonIds]);
        for (Contact forVar:ctsToUpdate){
            String newAccountName = newAccountNames.get(forVar.AccountId);
            if (forVar.LastName!=newAccountName){
                forVar.LastName = newAccountName;
            }
        }
        update ctsToUpdate;
    }

}