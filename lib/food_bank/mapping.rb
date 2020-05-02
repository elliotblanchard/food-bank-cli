class FoodBank::Mapping
  
  def self.check_address(address)
    Dotenv.load('.env') #Loads the API key
    Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_API_KEY']
    
    location = Geokit::Geocoders::GoogleGeocoder.geocode address
    
    if location.street_address == "" || location.street_address == nil  || location.street_name == "" || location.street_name == nil || location.street_number == "" || location.street_number == nil
      return false
    else
      return location.city
    end
  end
  
  def self.get_distance
    # You can also use the free API key instead of signed requests
    # See https://developers.google.com/maps/documentation/geocoding/#api_key
    
    Dotenv.load('.env') #Loads the API key
    Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_API_KEY']

    a=Geokit::Geocoders::GoogleGeocoder.geocode '140 Market St, San Francisco, CA'
    puts (a.ll) #Lat / Long
    b=Geokit::Geocoders::GoogleGeocoder.geocode '789 Geary St, San Francisco, CA'
    puts (b.ll) #Lat / Long
    puts (a.distance_to(b)) #In miles
    
    #As stub, just return a random distance between 1 and 10
    
    #To keep manageable, only calculate distances for food banks in same borough

  end
end