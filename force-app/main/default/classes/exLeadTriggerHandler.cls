public class exLeadTriggerHandler {
    public static void afterUpdate(List<Lead> newleadrecords,Map<Id,Lead>oldMap){
        //lead status changes to Qualified
        //create related Account,contact, Opportunity
        List<Account> acclist = new List<Account>();
        List<Contact> cntclist = new List<Contact>();
        List<Opportunity> opplist = new List<Opportunity>();
        for(Lead ledrecords:newleadrecords){
            if (ledrecords.Status!= oldMap.get(ledrecords.id).Status && ledrecords.Status =='Qualified'){
                acclist.add(new Account(name = 'test2'));
                cntclist.add(new Contact(LastName='test2'));
                opplist.add(new Opportunity(Name='test2',CloseDate = Date.Today(),StageName='Prospecting'));
            }
           
        }
         if(acclist.size()>0 && acclist !=null){
                insert acclist;
            }
            if(cntclist.size()>0 && cntclist !=null){
                insert cntclist;
            }
            if(opplist.size()>0 && opplist !=null){
                insert opplist;
            }
        
    }

}