public class boxfileuploadclass {
    @Future(callout=true)	
  public static void updatefile(string name,string strFolderId,blob b){
  
     //string token=
      TestObject__c test=[select id,Access_Token__c,Refresh_Token__c from TestObject__c where UserID__c=:userinfo.getuserid()];

        string refreshtoken=test.Refresh_Token__c ;
        
       //getting access token through refreshtoken
       HttpRequest req1 = new HttpRequest();
     req1.setEndpoint('https://api.box.com/oauth2/token');
     req1.setMethod('POST');
List<string> urlParams = new List<string>{'grant_type=refresh_token', 'refresh_token=' + EncodingUtil.urlEncode(refreshtoken, 'UTF-8'), 'client_id=' + EncodingUtil.urlEncode('a1b4xk6dw7p6ca86telimmpv5yhvhee0', 'UTF-8'), 'client_secret=' + EncodingUtil.urlEncode('Aeu8JE9twaIPcQsAOZ1r0TZWlhE694fu', 'UTF-8'), 'redirect_uri=' + EncodingUtil.urlEncode('https://c.ap4.visual.force.com/apex/MyTestPage1', 'UTF-8')};
        string reqbody = string.join(urlParams, '&'); 
system.debug('**req body**'+reqbody );
req1.setBody(reqbody );
 Http http1 = new Http();
     HttpResponse res1 = http1.send(req1);
    string body=res1.getBody();
     System.debug(res1.getBody());
     AccessWraper a=new AccessWraper();
     a=(AccessWraper)JSON.deserialize(body, AccessWraper.class);
     system.debug('**refresh_token**'+a.refresh_token);
system.debug('**access_token**'+a.access_token);
      string token=a.access_token;
        string boundary='----------------------------741e90d31eff';
        string header='--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+name+'";\nContent-Type: multipart/form-data;'+'\nnon-svg='+true;
        string footer='--'+boundary+'--';
        string headerEncoded=EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        HttpResponse res;
        string strFileId;
        while(headerEncoded.endsWith('=')){
            header+=' ';
            headerEncoded=EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        }
       string bodyEncoded=EncodingUtil.base64Encode(b);
        system.debug('====bodyEncoded ===='+bodyEncoded);
        Blob bodyBlob=null;
        string last4Bytes=bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
        if(last4Bytes.endsWith('==')){
            last4Bytes=last4Bytes.substring(0,2)+'0K';
            bodyEncoded=bodyEncoded.substring(0,bodyEncoded.length()-4)+last4Bytes;
            string footerEncoded=EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob=EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
            system.debug('====bodyBlob1 ===='+bodyBlob);
        }
        else if(last4Bytes.endsWith('=')){
            last4Bytes=last4Bytes.substring(0,3)+'N';
            bodyEncoded=bodyEncoded.substring(0,bodyEncoded.length()-4)+last4Bytes;
            footer='\n'+footer;
            string footerEncoded=EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob=EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
            system.debug('====bodyBlob2 ===='+bodyBlob);
        }
        else{
            footer='\r\n'+footer;
            string footerEncoded=EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob=EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
            system.debug('====bodyBlob2 ===='+bodyBlob);
        }
        string uploadfileendpoint1='https://upload.box.com/api/2.0/files/content?parent_id=';
       uploadfileendpoint1+=strFolderId;
       // uploadfileendpoint1+='/content';
        HttpRequest req=new HttpRequest();
        req.setHeader('Content-Type','multipart/form-data;non_svg='+true+';boundary='+boundary);
        req.setMethod('POST');
        req.setEndpoint(uploadfileendpoint1);
        req.setBodyAsBlob(bodyBlob);
        req.setTimeout(60000);
        req.setHeader('Authorization','Bearer '+token);
        req.setHeader('Content-Length',string.valueof(req.getBodyAsBlob().size()));
        Http http=new  Http();
        system.debug('*****size****'+req.getBodyAsBlob().size());
        res=http.send(req);
        system.debug('*****res body****'+res.getBody());
        system.debug('*****res status****'+res.getstatuscode());
    test.Access_Token__c=a.access_token;
    test.Refresh_Token__c =a.refresh_token;
    test.UserID__c=userinfo.getuserid();
    update test;
        
        
    }
public class AccessWraper
{
public string access_token{get; set;}
public string refresh_token{get; set;}
       // public Boolean selected {get; set;}
}
}