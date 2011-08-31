// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  if ($("#comments").length > 0) {
    setTimeout(updateComments, 10000);
  }
});

function updateComments () {
  $.getScript("/meals.js")
  setTimeout(updateComments, 10000);
}
//Datepicker
  $(document).ready(function() {
    $('#search_button').css("display","none");
    $("#datepicker").datepicker( { 
    		numberOfMonths: 1,
    		showWeek: true,
    		firstDay: 1,
    		dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
    		dayNamesShort : ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sa'],
    		dayNamesMin : ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sa'],
    		monthNames : ['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre'],
    		monthNamesShort: ['Jan','Fev','Mar','Avr','Mai','Juin','Juil','Aout','Sept','Oct','Nov','Dec'],
         altField: '#selectedDate',
        showButtonPanel: false,

        onSelect: function(dateText, inst) {
          //formatDate Requires a new date object to work
          var myDate = new Date(dateText);

          //Set a new var with different format to use
          var newFormat = $.datepicker.formatDate("yy/dd/mm", myDate);
          //Choose the div you want to replace
          //$("#selectedDate").html(newFormat);
          $('#send_date').submit();
        }
      }
    );
  });

var $container = $('#massonry_container');
$container.imagesLoaded(function(){
  $container.masonry({
    itemSelector : '.item',
    columnWidth : 600,
    gutterWidth: 50
  });
});

/*

//  <%= text_field_tag :search %>
//  <%= observe_field :search, :url => live_search_path, :update => :results %>


  $(document).ready(function() {
 	jQuery(function($) {
	  // when the #search field changes
	  $("#search").change(function() {
	    // make a POST call and replace the content
	    $.post(<%= live_search_path %>, function(data) {
	      $("#results").html(data);
	    });
	  });
	})
	});
	
*/
//Dialog
    $(function() {

        var dialogOpts = {
			 modal: true,
			 autoOpen: false,
			 minWidth: 600
        };
        $("#dialog").dialog(dialogOpts);
        $("#openDialog").click(function() {
          $("#dialog").dialog("open");
        });  
    });

// button
	$(function() {
		$("input:submit").button();
	});

	$(function() {
	    //find all form with class jqtransform and apply the plugin
	    $("form.jqtransform").jqTransform();
	});
