import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
	static targets = ["menu", "button"];
	static values = {
		open: Boolean,
	};
	connect() {
		leave(this.menuTarget);
		this.openValue = false;
	}

	close(event) {
		if (this.element.contains(event.target) === false) {
			leave(this.menuTarget);
			this.openValue = false;
		}
	}

	toggle() {
		if (this.openValue == true) {
			this.openValue = false;
			leave(this.menuTarget);
		} else {
			this.openValue = true;
			enter(this.menuTarget);
		}
	}
}
