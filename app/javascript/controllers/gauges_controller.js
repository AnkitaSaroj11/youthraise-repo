import { Controller } from "@hotwired/stimulus";
import JustGage from "justgage";

export default class extends Controller {
	static targets = ["chart"];
	static values = {
		min: Number,
		max: Number,
		maxText: String,
		currentText: String,
		current: Number,
	};
	canvasContext() {
		return this.chartTarget.getContext("2d");
	}

	connect() {
		console.log(this.maxTxtValue);
		new JustGage({
			id: "gauge",
			value: this.currentValue,
			min: this.minValue,
			max: this.maxValue,
			decimals: 0,
			gaugeWidthScale: 0.6,
			valueFontColor: "#ededed",
			levelColorsGradient: false,
			minTxt: "$0",
			maxTxt: this.maxTextValue,
			label: "Raised",
			labelFontColor: "#ededed",
			gaugeWidthScale: 1.0,
			gaugeColor: "#aeaeae",
			levelColors: ["#e67364"],
			valueMinFontSize: 12,
			labelMinFontSize: 12,
			minLabelMinFontSize: 14,
			maxLabelMinFontSize: 14,
			displayRemaining: false,
			textRenderer: (value) => "$" + value,
			pointer: true,
			pointerOptions: {
				toplength: null,
				bottomlength: null,
				bottomwidth: null,
				stroke: "none",
				stroke_width: 0,
				stroke_linecap: "square",
				color: "#ededed",
			},
		});
	}
}
