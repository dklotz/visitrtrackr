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
function update_visits(latitude, longitude, user_agent) {
	$( "#the-result" ).html( 'You come from (' + latitude + ',' + longitude + ') and your browser is: ' + user_agent );
	
	save_visit(latitude, longitude, user_agent);
}

function show_visits_results(visits, map) {
	$( "#status").html("We have " + visits.length + " visits.");
	
	var mapBounds = new google.maps.LatLngBounds();
	
	$.each(visits, function(index, visit) {
		var visitLocation = new google.maps.LatLng(visit.latitude, visit.longitude);
		
		mapBounds.extend(visitLocation);
		
		var marker = new google.maps.Marker({
			position: visitLocation,
			map: map,
			title: visit.useragent
		});
	});
	
	map.setCenter(mapBounds.getCenter());
	map.fitBounds(mapBounds);
}

function show_visits(map) {
	$( "#status").html("I can haz visits?");
	// Load all visits: 
	$.getJSON('/visits.json', function(result) {
		show_visits_results(result, map);
	});
}

function show_map(latitude, longitude) {
	
	$( "#status").html("I can haz Maps?");
	
	google.maps.visualRefresh = true;
	
	var myLoc = new google.maps.LatLng(latitude, longitude);
	
	var mapOptions = {
		center: myLoc,
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map(document.getElementById("geo-wrapper"), mapOptions);
	
	//var marker = new google.maps.Marker({
	//	position: myLoc,
	//	map: map,
	//	title:"Hello World!"
	//});
	
	return map;
}
