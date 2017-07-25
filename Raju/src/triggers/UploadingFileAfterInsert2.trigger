trigger UploadingFileAfterInsert2 on Attachment (after insert,after update) {
    
    for(attachment a:trigger.new){
        system.debug('attachment id'+a.id);
        account a1=[select id,Box_Id__c  from account where id =:a.parentid];
        boxfileuploadclass.updatefile(a.name,a1.Box_Id__c,a.body);
        
    }
}