import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
	static targets = ["source", "button", "supported", "unsupported"];

	connect() {
		if ("clipboard" in navigator) {
			enter(this.buttonTarget);
			enter(this.supportedTarget);
		} else {
			leave(this.buttonTarget);
			enter(this.unsupportedTarget);
		}
	}

	copy() {
		navigator.clipboard.writeText(this.sourceTarget.innerHTML);
		this.buttonTarget.innerHTML = "Copied!";
		setTimeout(() => this.buttonTarget.innerHTML = "Copy to Clipboard", 2000);
	}
}
