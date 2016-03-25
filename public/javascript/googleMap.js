$(document).ready(function(){

var address= "San Francisco"
 $("#wn2").whatsnearby({ 
     zoom:13,
     width:"99%",
     address: address,
     placesRadius: 10000,
     placeMainMarker: false,
     placesTypes: [ 'restaurants', 'cafe', 'museum', 'hotels', 'art_gallery', 'aquarium', 'park', 'stadium' ]
   });
  $('button').click(function(e){
    var address = document.getElementById('location').value
  
    $("#wn2").whatsnearby({ 
     zoom:13,
     width:"99%",
     address: address,
     placesRadius: 10000,
     placeMainMarker: false,
     placesTypes: [ 'restaurants', 'cafe', 'museum', 'hotels', 'art_gallery', 'aquarium', 'park', 'stadium' ]
   });
    e.preventDefault();
  });

  
 });

