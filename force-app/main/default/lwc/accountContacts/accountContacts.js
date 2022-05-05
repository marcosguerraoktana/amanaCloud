import { LightningElement, wire } from 'lwc';
import getContactByAccountID from '@salesforce/apex/AccountUtil.getContactByAccountID';


import SELECTED_ACCOUNT_CHANNEL from '@salesforce/messageChannel/SelectedAccount__c';
import { subscribe, MessageContext } from 'lightning/messageService';


export default class AccountContacts extends LightningElement {
    loading = false;
    contacts;
    account;
    @wire(MessageContext) messageContext;

    connectedCallback() {
        // Subscribe to ProductSelected message
        this.productSelectionSubscription = subscribe(
            this.messageContext,
            SELECTED_ACCOUNT_CHANNEL,
            (message) => this.handleProductSelected(message.account)
        );
    }

    handleProductSelected(account) {
        console.info(account);
        this.loading = true;
        this.account = account;
        getContactByAccountID({ requiredAccountId: account.Id}) .then(result => {
            if(result){
                console.log(result);
                this.contacts = result;
            }
            this.loading = false;
        });
    }
    get haveContacts(){
        if(this.contacts){
            return this.contacts.length > 0;
        }else{
            return false;
        }
    }

}