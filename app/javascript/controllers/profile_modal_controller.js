import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
	static targets = ["backdrop", "modal"];
	connect() {
		leave(this.modalTarget);
		leave(this.backdropTarget);
	}

	close() {
		leave(this.modalTarget);
		leave(this.backdropTarget);
	}

	open() {
		enter(this.modalTarget);
		enter(this.backdropTarget);
	}
}
