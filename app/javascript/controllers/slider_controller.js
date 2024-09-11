import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
	static targets = ["menu", "showbutton", "hidebutton", "overlay", "sidebar"];
	connect() {}

	close() {
		leave(this.menuTarget);
		leave(this.overlayTarget);
		leave(this.hidebuttonTarget);
	}

	open() {
		enter(this.overlayTarget);
		enter(this.menuTarget);
		enter(this.hidebuttonTarget);
	}
}
