trigger ChangingFraudCodeNew on Clarity_Response_New__c (before insert, before update) {
     system.debug('**artTest2***');  
    for(Clarity_Response_New__c c:trigger.new)
    {
        if(c.CF_Fraud_Description__c!=null )
        {
                     
            if(c.CF_Fraud_Description__c.contains('|'))
            system.debug('**artTest2***');    
               c.CF_Fraud_Description__c=c.CF_Fraud_Description__c.replace('|','\n');
               system.debug('**artTest2***'+c.CF_Fraud_Description__c);
                             
                            
        }
        
    }
}