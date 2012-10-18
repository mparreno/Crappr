var map;
var markers = [];

//window.onresize = trigger_resize;

function trigger_resize() {
	set_map_height_to($(document).height());
	google.maps.event.trigger(map, 'resize');
}

//sets the correct height of the map
//this should be called onload and onresize
function set_map_height_to(viewportheight) {
    var mainHeight = viewportheight - 62;
    var mapHeight = mainHeight;

    if ($('#map_div')) {
        $('#map_div').height(mapHeight);
    }
		if ($('#pana')) {
        $('#pana').height(mapHeight);
    }
}


function drawMap(minLng, minLat, maxLng, maxLat, mapType, zoomLevel) {
    // NZ bounding box
    var sw = new google.maps.LatLng(minLat, minLng)
    var ne = new google.maps.LatLng(maxLat, maxLng)

    // Create a bounding box  
    var bounds = new google.maps.LatLngBounds(sw, ne)

    var myOptions = {
        zoom: zoomLevel,
        center: bounds.getCenter(),
        mapTypeId: mapType,
        scrollwheel: false,
        scaleControl: true,
        overviewMapControl: true
    }
    
    map = new google.maps.Map(document.getElementById("map_div"), myOptions)
}

function getInfoWindowTextForToilet(name, link) {
    var text = '<div class="toilet">' + 
               '<h4>' + name + '</h4>' +
               '<p>' + link + '</p>' +
               '</div>'  
    return text
}

function addToiletMarker(name, latlng, link, icon) {
    var infowindow = new google.maps.InfoWindow({ content: getInfoWindowTextForToilet(name, link) });
    var marker = new google.maps.Marker({ position: latlng, map: map, title: name, icon: '/images/'+icon});
    markers.push(marker); 
    google.maps.event.addListener(marker, 'click', function() { infowindow.open(map, marker); });
}

//this should be used to face street view guy to a toilet
function bearing_from(pana,point) 
{
	var lat2 = pana.lat(); 
	var lon2 = pana.lng();
	var lat1 = point.lat(); 
	var lon1 = point.lng();
	
	var dLat = toRad((lat2-lat1));
	var dLon = toRad((lon2-lon1));
	var lat1 = toRad(lat1);
	var lat2 = toRad(lat2);
	
	var y = Math.sin(dLon) * Math.cos(lat2);
	var x = Math.cos(lat1)*Math.sin(lat2) -
	        Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLon);
	var brng = (toDeg(Math.atan2(y, x)) + 180) % 360;

	return brng;
}

function toRad(val){ return val * Math.PI / 180; }

function toDeg(val){ return val * 180 / Math.PI; }

function getIndex(){
	$.ajax({
		      beforeSend      : function(request) { request.setRequestHeader("Accept", "text/javascript"); },
		      type            : 'GET',
		      url             : '/toilets',
			  success		  : function() { loadToilets(); 
											 var mcOptions     = { gridSize: 50, maxZoom: 12 };
											 var markerCluster = new MarkerClusterer(map, markers, mcOptions);
											}
		});
}

function getMarkersFor(url, cluster){
	cluster = typeof(cluster) != 'undefined' ? cluster : 'true';
	$.getJSON(url, function(data) {
	
		$.each(data, function(key, val) {
					val.toilet.location + 
					addToiletMarker(val.toilet.location, 
						new google.maps.LatLng(val.toilet.lat,val.toilet.lng), 
						"<a href='/toilets/"+val.toilet.id+"'>View more information</a>", 
						"toilet.png"
						);
	  	});
			if (cluster) {
				var mcOptions     = { gridSize: 50, maxZoom: 12 };
				var markerCluster = new MarkerClusterer(map, markers, mcOptions);
			}
	
	});
	
}


