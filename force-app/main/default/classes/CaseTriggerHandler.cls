public with sharing class CaseTriggerHandler {
    public static void afterInsert(List<Case> insertedCasese){
     //	• Trigger: After a Case is created
     // Action: Create follow-up Tasks for Tier 1 Support team based on Case category 
     List<Task> taskstoInsert = new  List<Task> ();
      for (Case forVar :insertedCasese){
        if(forVar.Type =='Mechanical'|| forVar.Type =='Structural'){
          Task tsk=  new Task(OwnerId= forVar.OwnerId,Status=forVar.Status,Subject=forVar.Subject,Priority =forVar.Priority);
          taskstoInsert.add(tsk);
        }
      }
      if(taskstoInsert != null && taskstoInsert.size()>0){
        Insert taskstoInsert;
      }
    }
}