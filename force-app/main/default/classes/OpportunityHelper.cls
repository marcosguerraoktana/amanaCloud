public without sharing class OpportunityHelper {
    public static String WOOD_TYPE_STANDARD = 'Standard';
    public static String WOOD_TYPE_RECYCLED = 'Recycled';

    private static Map<Id,Integer>  newStandardWoodPerAccount;
    private static Map<Id,Integer>  newRecycledWoodPerAccount;

    public static void updateTotalSales() {
        if(Trigger.isAfter){
            newStandardWoodPerAccount= new Map<Id,Integer> ();
            newRecycledWoodPerAccount= new Map<Id,Integer> ();
            if (Trigger.isInsert || Trigger.isUndelete) {
                for(SObject newOpp: Trigger.new){
                    evaluateOpportunityAndUpdateMaps((Opportunity)newOpp, true);
                }
            }
            if (Trigger.isUpdate) {
                for(Id oppId: Trigger.newMap.keySet()){
                    if(Trigger.newMap.get(oppId).get('Wood_Type__c') != Trigger.oldMap.get(oppId).get('Wood_Type__c')){
                        evaluateOpportunityAndUpdateMaps((Opportunity)Trigger.newMap.get(oppId), true);
                        evaluateOpportunityAndUpdateMaps((Opportunity)Trigger.oldMap.get(oppId), false);
                    }
                }
            }
            if (Trigger.isDelete) {
                for(SObject oldOpp: Trigger.old){
                    evaluateOpportunityAndUpdateMaps((Opportunity)oldOpp, false);
                }               
            }
            updateTotalSalesOnAccounts();
        }
    }

    private static void updateTotalSalesOnAccounts(){
        if(newStandardWoodPerAccount.keySet().size() + newRecycledWoodPerAccount.keySet().size() > 0){
            List<Account> accountsToUpdate =  [SELECT Total_Sales_Standard_Wood__c, Total_Sales_Recycled_Wood__c FROM Account WHERE Id in :newStandardWoodPerAccount.keySet() OR Id in :newRecycledWoodPerAccount.keySet()];
            for(Account acc:accountsToUpdate){
                if(newStandardWoodPerAccount.get(acc.Id) != null){
                    if(acc.Total_Sales_Standard_Wood__c == null){
                        acc.Total_Sales_Standard_Wood__c = 0;
                    }
                    acc.Total_Sales_Standard_Wood__c = acc.Total_Sales_Standard_Wood__c + newStandardWoodPerAccount.get(acc.Id);
                }
                if(newRecycledWoodPerAccount.get(acc.Id) != null){
                    if(acc.Total_Sales_Recycled_Wood__c == null){
                        acc.Total_Sales_Recycled_Wood__c = 0;
                    }
                    acc.Total_Sales_Recycled_Wood__c = acc.Total_Sales_Recycled_Wood__c + newRecycledWoodPerAccount.get(acc.Id);
                }
            }
            update accountsToUpdate;
        }
    }

    private static void evaluateOpportunityAndUpdateMaps(Opportunity oppty, Boolean isAddCase){
        if(oppty.Wood_Type__c == WOOD_TYPE_STANDARD){
            updateCountMap(newStandardWoodPerAccount,oppty.AccountId,isAddCase);
        }else if(oppty.Wood_Type__c == WOOD_TYPE_RECYCLED){
            updateCountMap(newRecycledWoodPerAccount,oppty.AccountId,isAddCase);
        }    
    }

    
    private static void updateCountMap(Map<Id,Integer> usedMap, Id elementId, Boolean isAddCase){
        Integer value = 1;
        if(!isAddCase){
            value = -1;
        }
        if(usedMap.get(elementId) == null){
            usedMap.put(elementId,value);
        }else{
            usedMap.put(elementId,usedMap.get(elementId) + value);
        }
    }
}
