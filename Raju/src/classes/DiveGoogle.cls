public class DiveGoogle
{
public string code{get;set;}
public string body{get;set;}
public pageReference save1(){

code=ApexPages.currentPage().getParameters().get('code');
string sw=ApexPages.currentPage().getParameters().get('objid');
string id=ApexPages.currentPage().getParameters().get('state');

string pg='https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=99312901796-k6nrdnkbklji748qsau5bs3jb6ukvfbh.apps.googleusercontent.com&scope=https://www.googleapis.com/auth/drive&redirect_uri=https://ap4.salesforce.com/apex/DrivePage';
pageReference pr1=new pageReference(pg);
return pr1;
} 
}