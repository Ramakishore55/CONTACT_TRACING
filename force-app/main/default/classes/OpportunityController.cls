public class OpportunityController {
    public Static void updateOpportunity(List<Id>OppId){
        List<Opportunity> oppRecord =  [Select Id, Amount, Profile__c from Opportunity where Id IN:OppId];
        for(Opportunity  Opp: oppRecord){
          
            if (Opp.Amount==Null){
                Opp.Profile__c ='';
            }
            if(Opp.Amount<10000){
               Opp.Profile__c ='Low';
            }else if(Opp.Amount>50000){
                Opp.Profile__c ='High';
            }
            else{
                Opp.Profile__c ='Medium';
            }
            update Opp;
            
        }
        
    }

}