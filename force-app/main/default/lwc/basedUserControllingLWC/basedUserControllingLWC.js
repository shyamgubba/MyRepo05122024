import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';  
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';
import checkUserPermission from '@salesforce/apex/PermissionController.checkUserPermission';
export default class BasedUserControllingLWC extends LightningElement {
    @api recordId;
    canView = false;
    accountName;
    accountPhone;

    @wire(checkUserPermission)
    wiredPermission({ error, data }) {
        if (data) {
            this.canView = data;
        } else if (error) {
            console.error('Error checking permission', error);
        }
    }


    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD, ACCOUNT_PHONE_FIELD] })
    accountRecord({ data, error }) {
        if (data) {
            this.accountName = data.fields.Name.value;
            this.accountPhone = data.fields.Phone.value;
        } else if (error) {
            console.error(error);
        }
    }

}