public with sharing class TestDataGenerator {
    public static Id createAccount(String name){
        Account acc = new Account();
        acc.Name = name;
        insert acc;
        return acc.Id;
    }
    public static Id creataOpportunity(Id accountID, String name, String woodType){
        Opportunity opp = new Opportunity();
        opp.AccountId = accountID;
        opp.Wood_Type__c = woodType;
        opp.Name = name;
        opp.StageName = 'Closed';
        opp.CloseDate = Date.Today();
        insert opp;
        return opp.Id;
    }
    public static Id creataContact(Id accountID, String lastname){
        Contact cont = new Contact();
        cont.AccountId = accountID;
        cont.LastName = lastname;
        insert cont;
        return cont.Id;
    }
}
