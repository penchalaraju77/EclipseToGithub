trigger UploadingFileAfterInsert on Account (After insert) {
    for (account acc:Trigger.new)
    {
    if(Trigger.isInsert)
    {
       
            Attachment attach = new Attachment();
           // Blob blbbody;
           // blbbody = pdf.getContentAsPDF();
            //blbbody = Blob.valueOf('Some Text'+e);
           // attach.Body ='raju';
            attach.Name = 'Borrower360 Statement.pdf';
            attach.IsPrivate = false;
            attach.ParentId = acc.id;
            system.debug('-------attached----- '+attach.parentId);
            insert attach;
        
    }
    }

}