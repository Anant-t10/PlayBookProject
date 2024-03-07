import { api, track } from "lwc";
import LightningModal from "lightning/modal";
import { createRecord } from "lightning/uiRecordApi";

export default class BookingModal extends LightningModal {
    // @api turfDetailObj;
    name;
    email;
    @track _screenData;
    phone;

    handleChange(evt) {
        let value = evt.target.value;
        let fieldName = evt.target.dataset.name;
        this._screenData[fieldName] = value;
    }

    // handleBook() {
    //     this.close("Booked");
    // }

    @api set screenData(value) {
        this._screenData = JSON.parse(JSON.stringify(value));
    }

    get screenData() {
        return this._screenData;
    }

    objectApiName = "Booking__c";

    validateScreen() {
        let arr = this.template.querySelectorAll("lightning-input");
        let isValid = true;

        if (arr && arr.length > 0) {
            for (let index = 0; index < arr.length; index++) {
                const element = arr[index];
                let elementValid = element.reportValidity();
                isValid = isValid && elementValid;
            }
        }

        return isValid;
    }

    handleBooking() {
        if (this.validateScreen()) {
            let fields = {
                User_Name__c: this._screenData?.name,
                User_Email__c: this._screenData?.email,
                Start_Time__c: this._screenData?.searchStartTime,
                End_Time__c: this._screenData?.searchEndTime,
                User_Phone__c: this._screenData?.phone,
                Turf__c: this._screenData?.Id,
                Date__c: this._screenData?.searchDate
            };
            const recordInput = { apiName: this.objectApiName, fields: fields };
            createRecord(recordInput)
                .then((response) => {
                    console.log("Record created:", response.id);
                    this.close("Booked");
                })
                .catch((error) => {
                    console.error("Error creating record:", error);
                });
        }
    }
}