import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import PRODUCT_SELECTED_MESSAGE from '@salesforce/messageChannel/SelectedAccount__c';


export default class AccountItem extends LightningElement {
    @api account;
    @wire(MessageContext) messageContext;
    
    handleClick(){

        publish(this.messageContext, PRODUCT_SELECTED_MESSAGE, {
            account: this.account
        });
    }
}