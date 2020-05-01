class FoodBank::Scraper
  
  #Tutorial on searching XML with Nokogiri
  #https://nokogiri.org/tutorials/searching_a_xml_html_document.
  #http://ruby.bastardsbook.com/chapters/html-parsing/
  
  #Array of all the food banks: doc.css("Placemark")
  #Array of all the Food Bank names: doc.css("Placemark name") / doc.css("Placemark name").text
  #Array of all the Food Bank addresses: doc.css("Placemark address") / doc.css("Placemark address").text
  #...contact name: ????? doc.css("Placemark ExtendedData Data[name='Contact']").text
  #...phone: ????? doc.css("Placemark ExtendedData Data[name='Phone']").text
  #page.css("li[data-category='news']")
  
  def self.scrape_banks
    xml = File.read('fixtures/Food_Bank_For_NYC_Open_Members_as_of_42820.kml')
    doc = Nokogiri::XML(xml)    
    binding.pry
  end
  
end