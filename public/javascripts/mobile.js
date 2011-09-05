

$("#gps-btn").click(function() {
	$("#toilets-homepage-container").show();
	findNearestToilets(3);
	return false;
});

function scrollToHide(){
	setTimeout(scrollTo, 0, 0, 1);
}

//Scripts for the index page
function findNearestToilets(limit) {
  $('#toilets').html("Loading some crapprs...");
   if (gps_capable()) {
    getLocation(
      function(coords) {
        var lat = coords.latitude;
        var long = coords.longitude;
				
				$.getJSON('/api/toilets/nearby.json?lat=' + lat + '&lng=' + long + '&limit=' + limit, function(data) {
					 var items = [];
					
					  $.each(data, function(key, val) {
					    items.push('<li id="' + key + '">' + 
									'<a href="/toilets/'+ val.toilet.to_param + '">' +
									val.toilet.location + 
									'</a> (' +
									val.toilet.dist + 'm away)</li>');
					  });

					$('#toilets').html(  
						$('<ul/>', {
					    	'class': 'my-new-list',
					    	html: items.join('')
					  	})
					);
					$('<h2>Toilets:</h2>').prependTo('#toilets');

				});
				
      }, function() {
        $('#toilets').html("Sorry, we were unable to get your location. <a href='javascript:findNearestToilets();'>Retry.</a>");
      }
    );
  } else {
    $('#toilets').html("Sorry, your browser does not appear to support geolocation.");
  }
}

function toiletLink(toilets){
	
}

function toiletsToLI(){
	
}

function gps_capable() {
  var _locator_object;
  try {
    _locator_object = navigator.geolocation;
  } catch (e) {
    return false;
  }

  if (_locator_object) return true; else return false;
}

function getLocation(successCallback, errorCallback) {
  successCallback = successCallback || function(){};
  errorCallback = errorCallback || function(){};

  var geolocation = navigator.geolocation;

  if (geolocation) {
    try {
      function handleSuccess(position) {
				successCallback(position.coords);
      }

      geolocation.getCurrentPosition(handleSuccess, errorCallback, {
				enableHighAccuracy: true,
				maximumAge: 5000 // 5 sec.
      });
    } catch (err) {
      errorCallback();
    }
  } else {
    errorCallback();
  }
}

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

function drawMap(latlng, mapType, zoomLevel, id) {
	  var divid = id || "map_div";
    var myOptions = {
        zoom: zoomLevel,
        center: latlng,
        mapTypeId: mapType,
        scrollwheel: false,
        scaleControl: false,
        overviewMapControl: false,
				mapTypeControl: true
    }
  
    map = new google.maps.Map(document.getElementById(divid), myOptions)
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



