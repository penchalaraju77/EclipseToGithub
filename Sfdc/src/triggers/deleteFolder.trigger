trigger deleteFolder on account(before delete) {
 
        for (account acc : Trigger.old)
        {
            system.debug('**acc.Box_Id__c'+acc.Box_Id__c);
            Deletingfolder.save(acc.Box_Id__c);

        }

}