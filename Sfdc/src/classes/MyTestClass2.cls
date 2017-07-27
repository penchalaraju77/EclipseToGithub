Public class MyTestClass2
{

    public PageReference save() {
        return null;
    }

public string code{get;set;}
public string body{get;set;}

public pageReference save1(){


code=ApexPages.currentPage().getParameters().get('code');
string sw=ApexPages.currentPage().getParameters().get('objid');
string id=ApexPages.currentPage().getParameters().get('state');
if(code==null){
string pg='https://account.box.com/api/oauth2/authorize?response_type=code&client_id=a1b4xk6dw7p6ca86telimmpv5yhvhee0&redirect_uri=https%3A%2F%2Fc.ap4.visual.force.com%2Fapex%2FMyTestPage1&state='+sw;
pageReference pr1=new pageReference(pg);
return pr1;
}

      /*  Http m_http = new Http();
        HttpRequest req = new HttpRequest();
        
        
string body ='grant_type=authorization_code&code='+code;
body +='&client_id=3MVG9YDQS5WtC11pGNuCW6dXEYZ68AwotvnA6di.oor2cNZ3Kmk5Ctd9VQIRSz9EJ6mxJyVy4s7X.AIzmdiVH&client_secret=7937492860027326009&redirect_uri=https%3A%2F%2Fap4.salesforce.com%2Fapex%2FMyTestPage1';
        
        req.setEndpoint('http://login.salesforce.com/services/oauth2/token');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');        
        req.setMethod('POST');
        req.setBody(body );
        
        httpResponse response = m_http.send(req);
        system.debug('====res body==='+response.getbody());
 
//pageReference pr1=new pageReference('/code');*/
/*else{
HttpRequest req = new HttpRequest();
     req.setEndpoint('https://api.box.com/oauth2/token');
     req.setMethod('POST');
List<string> urlParams = new List<string>{'grant_type=authorization_code', 'code=' + EncodingUtil.urlEncode(code, 'UTF-8'), 'client_id=' + EncodingUtil.urlEncode('a1b4xk6dw7p6ca86telimmpv5yhvhee0', 'UTF-8'), 'client_secret=' + EncodingUtil.urlEncode('Aeu8JE9twaIPcQsAOZ1r0TZWlhE694fu', 'UTF-8'), 'redirect_uri=' + EncodingUtil.urlEncode('https://c.ap4.visual.force.com/apex/MyTestPage1', 'UTF-8')};
        string reqbody = string.join(urlParams, '&'); 
system.debug('**req body**'+reqbody );
req.setBody(reqbody );
 Http http = new Http();
     HttpResponse res = http.send(req);
     body=res.getBody();
     System.debug(res.getBody());
     AccessWraper a=new AccessWraper();
     a=(AccessWraper)JSON.deserialize(body, AccessWraper.class);
     system.debug('**refresh_token**'+a.refresh_token);
system.debug('**access_token**'+a.access_token);

    TestObject__c test=[select id,Access_Token__c,Refresh_Token__c from TestObject__c where id=:id];
    test.Access_Token__c=a.access_token;
    test.Refresh_Token__c =a.refresh_token;
    test.UserID__c=userinfo.getuserid();
    update test;
    pageReference pr2=new pageReference('/'+id);
   return pr2;  
}*/

return null;
}
public class AccessWraper
{
public string access_token{get; set;}
public string refresh_token{get; set;}
       // public Boolean selected {get; set;}
} 
}