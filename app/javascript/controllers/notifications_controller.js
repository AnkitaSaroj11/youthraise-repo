import { Controller } from "@hotwired/stimulus";
import { enter, leave } from "el-transition";

export default class extends Controller {
	static targets = ["notification"];
	connect() {
		enter(this.notificationTarget);
		setTimeout(() => {
			this.close();
		}, 5000);
	}

	close() {
		leave(this.notificationTarget);
	}

	open() {
		enter(this.notificationTarget);
	}
}
