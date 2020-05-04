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
    # Return array of food banks sorted by distance
    
    #Dotenv.load('.env') #Loads the API key
    #Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_API_KEY']

    user_location = self.get_location(user_address)
    
    puts "Looking up distances "
    
    # First get distances for each of the food banks
    banks.each_with_index do |bank, index|
      #bank_location = self.get_location(bank.address)
      banks[index].distance = user_location.distance_to(banks[index].location)
      print "\b\b\b\b" 
      percent_complete = (index.to_f+1.0)/banks.length.to_f
      print "#{(percent_complete.round(2)*100).to_i}%".colorize(:yellow).blink
    end
    
    puts "\n"
    banks_sorted = banks.sort_by { |bank| bank.distance }
    
    banks_sorted
  end
  
  def self.get_location(address)
    #Returns a location object of a street address using Geokit and the Google API
    Dotenv.load('.env') #Loads the API key
    Geokit::Geocoders::GoogleGeocoder.api_key = ENV['GOOGLE_API_KEY']
    
    Geokit::Geocoders::GoogleGeocoder.geocode address
  end
end