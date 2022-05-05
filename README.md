# Evaluation tasks summary

## Task 1: Improve Code

Not sure about the scope of the expected refactor, perhaps the idea was implemented some Design Pattern like Prototype to Factory and create new classes per each animal that will extend from the `Animal` class, but it could affect code that is currenty calling Animal class, for it I only made little changes on the class to clean the code and avoid access to unwanted methods.

## Task 2: Lightning Web Component

- LWC 1 is `accounts` and LWC 2 is `accountContacts`, `accountItem` is an auxiliar LWC used on `accounts`
- The apex class to provide data for both component is `AccountUtil` covered by the test class `AccountUtilTest` that generate data from `TestDataGenerator` class
- Message channel `selectedAccount` was created to communicate the components because the requiraments are not clear if the component will relared or not.

## Task 3: Rollup Trigger

Trigger  `OpportunityTrigger` was created only for needed events 
Apex class `OpportunityHelper` contain the main logic that is covered by the test class `OpportunityTriggerTest` that generate data from `TestDataGenerator` class
