//Retrieve Data Set
// url = "http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php"

// Import and Visualize Data using leaflet

//Create a map object
var myMap = L.map("map", {
  center: [37.09, -95.71],
  zoom: 5
});




var earthquakeMarkers = [];

// Loop through the cities array and create one marker for each city, bind a popup containing its name and population add it to the map
for (var i = 0; i < cities.length; i++) {
  var city = cities[i];
  L.marker(city.location)
    .bindPopup("<h1>" + city.name + "</h1> <hr> <h3>Population " + city.population + "</h3>")
    .addTo(myMap);
}

//
//create a legend