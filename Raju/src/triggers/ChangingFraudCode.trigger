trigger ChangingFraudCode on Clarity_Response__c (before insert, before update) {
    list<FraudCodes__c> codes=[select id,name,Fraud_Code__c,Reason_Code__c from FraudCodes__c];
    for(Clarity_Response__c c:trigger.new)
    {
            string firstStr='';
            String secondStr='';
            String thirdStr='';
               if(c.CF_Reason_Code__c!=null && (c.Fraud_Reason_Code_Description__c==null || c.Fraud_Reason_Code_Description__c=='')){
                   
                       String[] arrTest = c.CF_Reason_Code__c.split('\\|'); 
                       for( string s:arrTest){
                           for(FraudCodes__c f:codes)
                           {
                               if(s==string.valueof(f.Fraud_Code__c))
                               {
                                 
                           
                               // c.Fraud_Reason_Code_Description__c=f.Reason_Code__c; 
                               firstStr+='('+s+')'+ ' ' +f.Reason_Code__c+'|';

                                   system.debug('===Fraud_Reason_Code_Description__c===*******'+c.Fraud_Reason_Code_Description__c);
                               }        
                           }
                       }
                       
                       
                       c.Fraud_Reason_Code_Description__c=firstStr.removeend('|');
                }
                else if(c.Fraud_Reason_Code_Description__c!=null && (c.CF_Reason_Code__c==null || c.CF_Reason_Code__c==''))
                {
                    system.debug('***111***');
                    if(c.Fraud_Reason_Code_Description__c.contains('Worst') || c.Fraud_Reason_Code_Description__c.contains('|'))
                    {
                       // system.debug('***222***');
                        
                          //  system.debug('***333***');
                            String[] arrTest1 = c.Fraud_Reason_Code_Description__c.split('\\|');
                            system.debug('**artTest1***'+arrTest1);
                            for(Integer i = 0; i < =arrTest1.size()-1; i++)
                             {
                                 if(arrTest1[i].contains('Worst'))arrTest1[i]=arrTest1[i].replaceall('Worst','working');
                                  system.debug('**artTest2***'+arrTest1);
                                    secondStr+=arrTest1[i]+'|';
                            }
                        
                    }
                    c.Fraud_Reason_Code_Description__c=secondStr.removeend('|');
                }
                else if(c.CF_Reason_Code__c!=null && c.Fraud_Reason_Code_Description__c!=null)
                {
                    if(c.Fraud_Reason_Code_Description__c.contains('Worst') || c.Fraud_Reason_Code_Description__c.contains('|'))
                    {

                            String[] arrTest2 = c.Fraud_Reason_Code_Description__c.split('\\|');
                          //  system.debug('**artTest2***'+arrTest2);
                            for(Integer i = 0; i < =arrTest2.size()-1; i++)
                             {
                                 if(arrTest2[i].contains('Worst'))arrTest2[i]=arrTest2[i].replaceall('Worst','Working');
                                  system.debug('**artTest2***'+arrTest2);
                                    thirdStr+=arrTest2[i]+'|';
                            }
                        
                    }
                    c.Fraud_Reason_Code_Description__c=thirdStr.removeend('|');
                
                
                
                }                
    }
}