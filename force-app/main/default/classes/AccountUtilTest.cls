@isTest
public class AccountUtilTest {
    private static String UNEXPECTED_ACCOUNTS = 'Unexpected number of accounts';
    private static String UNEXPECTED_CONTACTS = 'Unexpected number of contacts';

    @TestSetup
    static void createData(){
        Id accountId = TestDataGenerator.createAccount('TestAccount');
        TestDataGenerator.creataContact(accountId, 'Simpson');
        TestDataGenerator.creataContact(accountId, 'Smith');
    }

    @isTest
    private static void getAccountsTest(){
        List<Account> accounts;
        Test.startTest();
            accounts = AccountUtil.getAccounts();
        Test.stopTest();
        System.assertEquals(1, accounts.size(), UNEXPECTED_ACCOUNTS);
    }

    @isTest
    private static void getContactByAccountTest(){
        Account account = getAccount();
        List<Contact> contacts;

        Test.startTest();
            contacts = AccountUtil.getContactByAccountID(account.Id);
        Test.stopTest();
        System.assertEquals(2, contacts.size(), UNEXPECTED_CONTACTS);
    }

    private static Account getAccount(){
        Account acc = [SELECT Name, Total_Sales_Recycled_Wood__c,Total_Sales_Standard_Wood__c FROM Account LIMIT 1];
        return acc;
    }
}
