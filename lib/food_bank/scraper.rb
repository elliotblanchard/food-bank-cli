class FoodBank::Scraper
  
  def scrape_banks
    xml = File.read('fixtures/Food_Bank_For_NYC_Open_Members_as_of_42820.kml')
    doc = Nokogiri::XML(xml)    
    binding.pry
  end
  
end