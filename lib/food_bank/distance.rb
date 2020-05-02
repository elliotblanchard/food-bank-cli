class FoodBank::Distance
  
  def self.get_distance
    # You can also use the free API key instead of signed requests
    # See https://developers.google.com/maps/documentation/geocoding/#api_key
    Geokit::Geocoders::GoogleGeocoder.api_key = 'AIzaSyBaZmAGeVJL0jBXkeFqBHTkS2xxlGAki0Y'    

    a=Geokit::Geocoders::GoogleGeocoder.geocode '140 Market St, San Francisco, CA'
    puts (a.ll) #Lat / Long
    b=Geokit::Geocoders::GoogleGeocoder.geocode '789 Geary St, San Francisco, CA'
    puts (b.ll) #Lat / Long
    puts (a.distance_to(b)) #In miles
    
    #To keep manageable, only calculate distances for food banks in same borough

  end
end