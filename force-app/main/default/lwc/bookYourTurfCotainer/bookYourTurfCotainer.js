import { LightningElement, track } from "lwc";
import searchForTurf from "@salesforce/apex/AllTurfController.searchForTurf";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class BookYourTurfCotainer extends LightningElement {
    @track searchDate;
    @track searchStartTime;
    @track searchEndTime;

    @track screenData = {};

    handleChange(evt) {
        let value = evt.target.value;
        let fieldName = evt.target.dataset.name;

        this.screenData[fieldName] = value;
    }

    @track searchResultTurfs = [];

    searchTurfFromDB() {
        searchForTurf({ param: this.screenData })
            .then((result) => {
                let mappedArray = result.map((item) => {
                    let obj = {};
                    obj = {
                        ...item,
                        searchStartTime: this.screenData.searchStartTime + "Z",
                        searchDate: this.screenData.searchDate,
                        searchEndTime: this.screenData.searchEndTime + "Z"
                    };
                    return obj;
                });
                this.searchResultTurfs = mappedArray;
            })
            .catch((error) => {
                const event = new ShowToastEvent({
                    title: "Error",
                    message: error[0].message
                });
                this.dispatchEvent(event);
            });
    }
}