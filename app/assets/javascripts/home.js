//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.

// Saves the visit in the backend and sets a cookie to prevent duplicates
function save_visit(latitude, longitude, user_agent) {
	if (!$.cookie('visitrTrcked')) {
		// Save to backend
		$.post("/visits.json", { visit: { useragent: user_agent, latitude: latitude, longitude: longitude } } );
		// Set a cookie that expires 24h from now
		$.cookie('visitrTrcked', 'true', { expires: 1, path: '/' });
		$( "#status").html("Visit saved!");
	} else {
		$( "#status").html("Visit already registered, you have to wait 24h!");
	}
}

// Updates the page with the geolocation result
function update_result(latitude, longitude, user_agent) {
	// TODO: Load all visits: $.getJSON('http://...', function(data) {
    //            $( "#status").html=data.date; // ...
    //      });
	$( "#the-result" ).html( 'You come from (' + latitude + ',' + longitude + ') and your browser is: ' + user_agent );
	
	$( "#status").html("I can haz Maps?");
	
	google.maps.visualRefresh = true;
	
	var myLoc = new google.maps.LatLng(latitude, longitude);
	
	var mapOptions = {
		center: myLoc,
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map(document.getElementById("geo-wrapper"), mapOptions);
	
	var marker = new google.maps.Marker({
		position: myLoc,
		map: map,
		title:"Hello World!"
	});
	
	save_visit(latitude, longitude, user_agent);
}
