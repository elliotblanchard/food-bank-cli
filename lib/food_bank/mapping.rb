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
  
  def self.get_distance(user_address,banks)
    # You can also use the free API key instead of signed requests
    # See https://developers.google.com/maps/documentation/geocoding/#api_key
    # Return array of food banks sorted by distance
    
    Dotenv.load('.env') #Loads the API key
    Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_API_KEY']

    puts "Looking up distances "
    
    # First get distances for each of the food banks
    banks.each_with_index do |bank, index|
      user_location = Geokit::Geocoders::GoogleGeocoder.geocode user_address
      bank_location = Geokit::Geocoders::GoogleGeocoder.geocode bank.address
      banks[index].distance = user_location.distance_to(bank_location)
      sleep(0.125)
      print "\b\b\b\b\b\b\b\b\b\b" 
      percent_complete = (index.to_f+1.0)/banks.length.to_f
      print "#{(percent_complete.round(2)*100).to_i}%".colorize(:yellow).blink
    end
    
    puts "\n"
    banks_sorted = banks.sort_by { |bank| bank.distance }
    
    banks_sorted
    
    #a=Geokit::Geocoders::GoogleGeocoder.geocode '140 Market St, San Francisco, CA'
    #puts (a.ll) #Lat / Long
    #b=Geokit::Geocoders::GoogleGeocoder.geocode '789 Geary St, San Francisco, CA'
    #puts (b.ll) #Lat / Long
    #puts (a.distance_to(b)) #In miles
    

  end
end