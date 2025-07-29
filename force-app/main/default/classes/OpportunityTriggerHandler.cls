public with sharing class OpportunityTriggerHandler {

    public static void afterInsert(List<Opportunity> newOps){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Set<Id> oppIdsToSendEmail = new Set<Id>();
        
        // 1. Identify Opportunities that meet the criteria for email (Amount > 10000)
        for(Opportunity opp : newOps){
            if(opp.Amount != null && opp.Amount > 10000){
                oppIdsToSendEmail.add(opp.Id);
            }
        }

        // Only proceed if there are opportunities to send emails for
        if(oppIdsToSendEmail.isEmpty()){
            return;
        }

        // 2. Query for these specific Opportunities, including Owner details
        // Store them in a map for easy lookup by Id
        Map<Id, Opportunity> opportunitiesWithOwners = new Map<Id, Opportunity>(
            [SELECT Id, Name, OwnerId, Owner.Email, Owner.Name FROM Opportunity WHERE Id IN :oppIdsToSendEmail]
        );

        // 3. Iterate through the queried opportunities to construct emails
        for(Opportunity opp : opportunitiesWithOwners.values()){ // Iterate values of the map
            // Ensure Owner Email exists before trying to send
            if (opp.Owner.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[]{opp.Owner.Email});
                mail.setSubject('New High-Value Opportunity: ' + opp.Name); // More specific subject for new
                mail.setHtmlBody('Hello ' + opp.Owner.Name + ',<br><br>A new opportunity, "' + opp.Name + '", with an amount of $' + opp.Amount + ' has been created. <br><br>Best regards,<br>Salesforce Automated Message');
                mail.setSaveAsActivity(false); // Optional: Prevents email from showing as an activity on the record
                emails.add(mail);
            } else {
                System.debug('Opportunity ' + opp.Id + ' has a null Owner.Email. Skipping email.');
            }
        }
        
        // 4. Send emails if the list is not empty
        if (!emails.isEmpty()){
            try {
                Messaging.sendEmail(emails); 
            } catch(EmailException e){
                system.debug('Error sending email from afterInsert: ' + e.getMessage());
            }
        }
    }

    public static void afterUpdate(List<Opportunity> newOps, Map<Id,Opportunity> oldMap){ 
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Set<Id> oppIdsToSendEmail = new Set<Id>();
        
        // 1. Identify Opportunities where Amount has changed AND new Amount > 10000
        for(Opportunity newOpp : newOps){
            Opportunity oldOpp = oldMap.get(newOpp.Id);
            if (newOpp.Amount != null && oldOpp.Amount != null && 
                newOpp.Amount != oldOpp.Amount && newOpp.Amount > 10000) {
                oppIdsToSendEmail.add(newOpp.Id);
            }
        }

        // Only proceed if there are opportunities to send emails for
        if(oppIdsToSendEmail.isEmpty()){
            return;
        }

        // 2. Query for these specific Opportunities, including Owner details
        Map<Id, Opportunity> opportunitiesWithOwners = new Map<Id, Opportunity>(
            [SELECT Id, Name, OwnerId, Owner.Email, Owner.Name, Amount FROM Opportunity WHERE Id IN :oppIdsToSendEmail]
        );
        
        // 3. Iterate through the queried opportunities to construct emails
        for(Opportunity opp : opportunitiesWithOwners.values()){ // Iterate values of the map
            // Ensure Owner Email exists before trying to send
            if (opp.Owner.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[]{opp.Owner.Email});
                mail.setSubject('High-Value Opportunity Update: ' + opp.Name); // More specific subject for update
                mail.setHtmlBody('Hello ' + opp.Owner.Name + ',<br><br>The opportunity "' + opp.Name + '" has been updated and now has an amount of $' + opp.Amount + '.<br><br>Best regards,<br>Salesforce Automated Message');
                mail.setSaveAsActivity(false);
                emails.add(mail);
            } else {
                System.debug('Opportunity ' + opp.Id + ' has a null Owner.Email. Skipping email.');
            }
        }
        
        // 4. Send emails if the list is not empty
        if (!emails.isEmpty()){
            try {
                Messaging.sendEmail(emails); 
            } catch(EmailException e){
                system.debug('Error sending email from afterUpdate: ' + e.getMessage());
            }
        }
    }
}