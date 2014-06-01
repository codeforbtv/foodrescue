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
		input: 'input',
		fake_submit: '#fake_submit'
	},
	init: function() {
		var _this = this;

		_this.formEnterDisable();
		_this.fakeSubmitHelper();
	},
	formEnterDisable: function() {
		// Disable enter key form submission
		$(this.sel.input).keypress(function (e) {
		    var k = e.keyCode || e.which;
		    if (k == 13) {
		        return false; // !!!
		    }
		});
	},
	fakeSubmitHelper: function() {
		// Tabbing focus ignores the fake submit button on the homepage
		$(this.sel.fake_submit).focus(function(){
			console.log('You are focusing the fake button!');
			$(this).next('.option').children('button').focus();
		});
	}
};

$(document).ready(function() {
	frv.util.init();
});