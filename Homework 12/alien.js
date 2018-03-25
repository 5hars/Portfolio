// Get references to the tbody element, input field and button
var $tbody = document.querySelector("tbody");
var $datedata = document.querySelector("#date");
var $citydata = document.querySelector("#city");
var $statedata = document.querySelector("#state");
var $countrydata = document.querySelector("#country");
var $shapedata = document.querySelector("#shape");
var $durationdata = document.querySelector("#duration");
var $commentdata = document.querySelector("#comment");

// Add an event listener to the searchButton, call handleSearchButtonClick when clicked
$searchBtn.addEventListener("click", handleSearchButtonClick);

// Set filtereData to CompleteData initially
var filteredData = CompleteData;

// renderTable renders the filteredAddresses to the tbody
function renderTable() {
  $tbody.innerHTML = "";
  for (var i = 0; i < filteredData.length; i++) {
    // Get get the current address object and its fields
    var address = filteredData[i];
    var fields = Object.keys(address);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var $row = $tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the address object, create a new cell at set its inner text to be the current value at the current address's field
      var field = fields[j];
      var $cell = $row.insertCell(j);
      $cell.innerText = address[field];
    }
  }
}

function handleSearchButtonClick() {
  // Format the user's search by removing leading and trailing whitespace, lowercase the string
  var filtereData = $datedata.value.trim().toLowerCase();
  var filterCity = $citydata.value.trim().toLowerCase();
  var filterCountry = $countrydata.value.trim().toLowerCase();
  var filterState = $statedata.value.trim().toLowerCase();
  var filterDuration = $durationdata.value.trim().toLowerCase();
  var filterShape = $shapedata.value.trim().toLowerCase();

  // Set filteredAddresses to an array of all addresses whose fields matches the filter
  filteredData = DataSet.filter(function(data) {
    var filteredDate = data.datetime.toLowerCase();
    var filteredCity = data.city.toLowerCase();
    var filteredState = data.state.toLowerCase();
    var filteredCountry = data.country.toLowerCase();
    var filteredDuration = data.durationdata.toLowerCase();
    var filteredShape = data.shape.toLowerCase();

    // If true, add the address to the filteredAddresses, otherwise don't add it to filteredAddresses
    if 



    return addressState === filterState;
  });
  renderTable();
}

// Render the table for the first time on page load
renderTable();



























