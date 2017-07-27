public class MyTestClass {

//System.debug('Id ' + id);
public pageReference save()
{
ID id=ApexPages.currentPage().getParameters().get('objid');
system.debug('==id=='+id);
pageReference pr=new pageReference('https://login.salesforce.com/services/oauth2/authorize??prompt=login%20consent&response_type=code&client_id=3MVG9YDQS5WtC11pGNuCW6dXEYZ68AwotvnA6di.oor2cNZ3Kmk5Ctd9VQIRSz9EJ6mxJyVy4s7X.AIzmdiVH&redirect_uri=https%3A%2F%2Fap4.salesforce.com%2Fapex%2FMyTestPage1&state='+id);

return pr;
}
public pageReference save1(){

string code=ApexPages.currentPage().getParameters().get('code');

       /* Http m_http = new Http();
        HttpRequest req = new HttpRequest();
        
        POST /services/oauth2/token HTTP/1.1
Host: login.salesforce.com 
grant_type=authorization_code&code=aPrxsmIEeqM9PiQroGEWx1UiMQd95_5JUZ
VEhsOFhS8EVvbfYBBJli2W5fn3zbo.8hojaNW_1g%3D%3D&client_id=3MVG9lKcPoNI
NVBIPJjdw1J9LLM82HnFVVX19KY1uA5mu0QqEWhqKpoW3svG3XHrXDiCQjK1mdgAvhCs
cA9GE&client_secret=1955279925675241571&
redirect_uri=https%3A%2F%2Fwww.mysite.com%2Fcode_callback.jsp
        
        req.setEndpoint('http://xyz/BMEapp/API.asmx/listCreate');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');        
        req.setMethod('POST');
        req.setBody(content);
        
        httpResponse response = m_http.send(req);*/
 
pageReference pr1=new pageReference('/code');


return pr1;
}

}