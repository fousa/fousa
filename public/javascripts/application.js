var Fousa = {

	init: function() {
		Fousa.toggle_note();
		$("input#post_note").click(Fousa.toggle_note);
	},

	toggle_note: function() {
		if ($("input#post_note").attr("checked")) {
			Fousa.set_article_fields("none");
		} else {
			Fousa.set_article_fields("table-row");
		}
	},

	set_article_fields: function(display) {
		$("tr#post_title_row").css("display", display);
		$("tr#post_permalink_row").css("display", display);
		$("tr#post_tag_list_row").css("display", display);
	}

}

$(Fousa.init);