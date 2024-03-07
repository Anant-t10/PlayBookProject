import { LightningElement, wire, track } from "lwc";
import getAllTurfs from "@salesforce/apex/AllTurfController.getAllTurfs";

export default class AllTurfsContainer extends LightningElement {
  @track turfsList = [];

  @wire(getAllTurfs)
  wireDataTurf(allTurfs) {
    if (allTurfs.data) {
      this.turfsList = allTurfs.data;
    }
  }
}