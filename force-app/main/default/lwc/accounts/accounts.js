import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountUtil.getAccounts';



export default class Accounts extends LightningElement {
    @wire(getAccounts)
    accounts;

    get haveAccounts(){
        if(this.accounts.data){
            return this.accounts.data.length > 0;
        }else{
            return false;
        }
    }
}