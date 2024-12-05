import { LightningElement,api,track } from 'lwc';
import {setName} from 'c/utilityFile';
export default class ChildLWC extends LightningElement {
    isClicked=false;
    @api childmessage;
    @track count=0;
    @track message1FromParent;
    @track message2FromParent

    constructor(){
        super();
    }
    handleClick(){
        
        if(this.isClicked==false){
            this.isClicked=true;
            console.log('This is INSIDE CHILD'+this.childmessage);
        }
        else if(this.isClicked==true){
            this.isClicked=false;
            console.log('This is INSIDE CHILD FALSE'+this.childmessage);
        }
    }
    @api handleForClickIncrease(){
        this.count++
        setName('msg','Child Message for Utility JS');
    }
    @api handleForClickDecrease(){
        this.count--
    }
    @api connectedCallback(var1,var2) {
        //code
        this.message1FromParent = var1;
        this.message2FromParent = var2;
        console.log(var1);
        console.log(var2);
    }

    

}