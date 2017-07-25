public with sharing class MyTestClass3 {

string sw=ApexPages.currentPage().getParameters().get('accId');


    public PageReference save() {
            //string refreshtokentest=[select id,Refresh_Token__c from TestObject__c where UserID__c=:userinfo.getuserid() limit 1].Refresh_Token__c ;

        TestObject__c test=[select id,Access_Token__c,Refresh_Token__c from TestObject__c where UserID__c=:userinfo.getuserid()];

        string refreshtoken=test.Refresh_Token__c ;
        
       //getting access token through refreshtoken
       HttpRequest req = new HttpRequest();
     req.setEndpoint('https://api.box.com/oauth2/token');
     req.setMethod('POST');
List<string> urlParams = new List<string>{'grant_type=refresh_token', 'refresh_token=' + EncodingUtil.urlEncode(refreshtoken, 'UTF-8'), 'client_id=' + EncodingUtil.urlEncode('a1b4xk6dw7p6ca86telimmpv5yhvhee0', 'UTF-8'), 'client_secret=' + EncodingUtil.urlEncode('Aeu8JE9twaIPcQsAOZ1r0TZWlhE694fu', 'UTF-8'), 'redirect_uri=' + EncodingUtil.urlEncode('https://c.ap4.visual.force.com/apex/MyTestPage1', 'UTF-8')};
        string reqbody = string.join(urlParams, '&'); 
system.debug('**req body**'+reqbody );
req.setBody(reqbody );
 Http http = new Http();
     HttpResponse res = http.send(req);
    string body=res.getBody();
     System.debug(res.getBody());
     AccessWraper a=new AccessWraper();
     a=(AccessWraper)JSON.deserialize(body, AccessWraper.class);
     system.debug('**refresh_token**'+a.refresh_token);
system.debug('**access_token**'+a.access_token);

account acc=[select id,name from account where id=:sw];

//creating folder in Box
 HttpRequest req1 = new HttpRequest();
     req1.setEndpoint('https://api.box.com/2.0/folders');
     req1.setMethod('POST');
     req1.setHeader('Authorization', 'Bearer ' +a.access_token);
string body1='{"name":"'+acc.name+'", "parent": {"id": "30391427032"}}';
system.debug('**req body**'+body1 );
req1.setBody(body1 );
 Http http1 = new Http();
     HttpResponse res1 = http1.send(req1);
    string body2=res1.getBody();
     System.debug(res1.getBody());
     CreatingFolderWraper wrap=new CreatingFolderWraper();
     wrap=(CreatingFolderWraper)JSON.deserialize(body2, CreatingFolderWraper.class);
system.debug('**box name**'+wrap.id);
  //  TestObject__c test=[select id,Access_Token__c,Refresh_Token__c from TestObject__c where id=:id];
    test.Access_Token__c=a.access_token;
    test.Refresh_Token__c =a.refresh_token;
    test.UserID__c=userinfo.getuserid();
    update test;
    
acc.Box_Id__c=wrap.id;
update acc;
      pageReference pr2=new pageReference('/'+sw);
   return pr2;
 return null;
    }
public class AccessWraper
{
public string access_token{get; set;}
public string refresh_token{get; set;}
       // public Boolean selected {get; set;}
}
public class CreatingFolderWraper
{
public string id{get; set;}

     
}
}