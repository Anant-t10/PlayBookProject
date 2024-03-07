import { LightningElement, api } from "lwc";
import bookingModal from "c/bookingModal";

export default class BookTurfCard extends LightningElement {
    @api turfObj;

    async handleBookButton() {
        await bookingModal.open({
            size: "large",
            description: "Book thr Turf",
            screenData: JSON.parse(JSON.stringify(this.turfObj))
        });
    }
}