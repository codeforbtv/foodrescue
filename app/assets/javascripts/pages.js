// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// Dependencies:
//	- jQuery

var frv = frv || {};

frv.util = {
	conf: {
	},
	sel: {
	},
	init: function() {
		var _this = this;

		_this.formEnterDisable();
	},
	formEnterDisable: function() {
		//handle enter key
		$("input").keypress(function (e) {
		    var k = e.keyCode || e.which;
		    if (k == 13) {
		        return false; // !!!
		    }
		});
	}
};

$(document).ready(function() {
	frv.util.init();
});