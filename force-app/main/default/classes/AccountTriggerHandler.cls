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

}