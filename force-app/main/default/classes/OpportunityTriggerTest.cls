@isTest
public class OpportunityTriggerTest {
    private static String UNEXPECTED_TOTAL_SALES_REC_WOOD = 'Unexpected total sales recycled wood amount';
    private static String UNEXPECTED_TOTAL_SALES_STD_WOOD = 'Unexpected total sales standard wood amount';

    @TestSetup
    static void createData(){
        Id accountId = TestDataGenerator.createAccount('TestAccount');
        TestDataGenerator.creataOpportunity(accountId, 'Oppty1', OpportunityHelper.WOOD_TYPE_STANDARD);
        TestDataGenerator.creataOpportunity(accountId, 'Oppty2', OpportunityHelper.WOOD_TYPE_STANDARD);
        TestDataGenerator.creataOpportunity(accountId, 'Oppty3', OpportunityHelper.WOOD_TYPE_RECYCLED);

        Account acc = getAccount();
        System.assertEquals(1, acc.Total_Sales_Recycled_Wood__c, UNEXPECTED_TOTAL_SALES_REC_WOOD);
        System.assertEquals(2, acc.Total_Sales_Standard_Wood__c, UNEXPECTED_TOTAL_SALES_STD_WOOD);
    }

    @isTest
    private static void checkInsertValues(){
        Account acc = getAccount();

        Test.startTest();
            TestDataGenerator.creataOpportunity(acc.Id, 'Oppty4', OpportunityHelper.WOOD_TYPE_RECYCLED);
        Test.stopTest();
        
        acc = getAccount();
        System.assertEquals(2, acc.Total_Sales_Recycled_Wood__c, UNEXPECTED_TOTAL_SALES_REC_WOOD);
        System.assertEquals(2, acc.Total_Sales_Standard_Wood__c, UNEXPECTED_TOTAL_SALES_STD_WOOD);
    }
    @isTest
    private static void checkUpdateValues(){
        List<Opportunity> oppties = getOpportunities();

        Test.startTest();
            for(Opportunity opp: oppties){
                if(opp.Wood_Type__c == OpportunityHelper.WOOD_TYPE_STANDARD){
                    opp.Wood_Type__c = OpportunityHelper.WOOD_TYPE_RECYCLED;
                }else{
                    opp.Wood_Type__c = OpportunityHelper.WOOD_TYPE_STANDARD;
                }
            }
            update oppties;
        Test.stopTest();

        Account acc = getAccount();

        System.assertEquals(2, acc.Total_Sales_Recycled_Wood__c, UNEXPECTED_TOTAL_SALES_REC_WOOD);
        System.assertEquals(1, acc.Total_Sales_Standard_Wood__c, UNEXPECTED_TOTAL_SALES_STD_WOOD);
    }

    @isTest
    private static void checkDeleteValues(){
        List<Opportunity> oppties = getOpportunities();

        Test.startTest();
            delete oppties;
        Test.stopTest();

        Account acc = getAccount();

        System.assertEquals(0, acc.Total_Sales_Recycled_Wood__c, UNEXPECTED_TOTAL_SALES_REC_WOOD);
        System.assertEquals(0, acc.Total_Sales_Standard_Wood__c, UNEXPECTED_TOTAL_SALES_STD_WOOD);
    }

    @isTest
    private static void checkUnDeleteValues(){
        List<Opportunity> oppties = getOpportunities();
        delete oppties;

        Test.startTest();
            undelete oppties;

        Test.stopTest();

        Account acc = getAccount();

        System.assertEquals(1, acc.Total_Sales_Recycled_Wood__c, UNEXPECTED_TOTAL_SALES_REC_WOOD);
        System.assertEquals(2, acc.Total_Sales_Standard_Wood__c, UNEXPECTED_TOTAL_SALES_STD_WOOD);
    }

    private static Account getAccount(){
        Account acc = [SELECT Name, Total_Sales_Recycled_Wood__c,Total_Sales_Standard_Wood__c FROM Account LIMIT 1];
        return acc;
    }

    private static List<Opportunity> getOpportunities(){
        List<Opportunity> oppties = [SELECT Id, Wood_Type__c FROM Opportunity];
        return oppties;
    }
}
