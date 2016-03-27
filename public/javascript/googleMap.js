$(document).ready(function(){

  var address= "San Francisco";

  $("#wn2").whatsnearby({ 
     zoom:10,
     width:"99%",
     address: address,
     placesRadius: 10000,
     placeMainMarker: false,
     placesTypes: [ 'restaurants', 'cafe', 'museum', 'hotels', 'art_gallery', 'aquarium', 'park', 'stadium' ]
   });


  function pressSearchButton(e){
    var address = document.getElementById('location').value;
    document.getElementById('result_search').innerHTML = address;
    $("#wn2").whatsnearby({ 
     zoom:12,
     width:"%",
     address: address,
     placesRadius: 10000,
     placeMainMarker: false,
     placesTypes: [ 'restaurants', 'cafe', 'museum', 'hotels', 'art_gallery', 'aquarium', 'park', 'stadium' ]
   });
   
   // google.maps.event.trigger($("#wn2").whatsnearby().map(), 'resize');
    if (e) {
      e.preventDefault();
    }
  }

  $('#submit').click(pressSearchButton);

  setTimeout(pressSearchButton, 0);  


 });

