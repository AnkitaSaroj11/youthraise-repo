import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["parent", "child"];
	connect() {
		this.parentTarget.checked = false;
	}

	toggleChildren() {
		if (this.parentTarget.checked) {
			this.childTargets.map((x) => (x.checked = true));
		} else {
			this.childTargets.map((x) => (x.checked = false));
		}
	}

	toggleParent() {
		if (this.childTargets.map((x) => x.checked).includes(false)) {
			this.parentTarget.checked = false;
		} else {
			this.parentTarget.checked = true;
		}
	}
}
