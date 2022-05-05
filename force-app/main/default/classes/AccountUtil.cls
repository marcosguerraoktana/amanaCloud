public class AccountUtil{

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name FROM Account LIMIT 50000];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactByAccountID(String requiredAccountId){
        return [SELECT Id, Name FROM Contact WHERE AccountId = :requiredAccountId LIMIT 50000];
    }
    
}