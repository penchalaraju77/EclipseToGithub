trigger SendingApplicationIdToBorrower on Contact (after insert) {

    list<contact> con=new list<contact>();
    for(contact c:Trigger.new)
    {
        if(c.LeadSource=='Phone Inquiry'){
          
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
mail.setTargetObjectId(c.id);

mail.setSenderDisplayName('Happiest Minds');
mail.setSubject('Test Mail');

string body= System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+c.id;
mail.setPlainTextBody(body);

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}