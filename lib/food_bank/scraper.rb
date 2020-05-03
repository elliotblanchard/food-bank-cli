class FoodBank::Scraper
  
  #Tutorial on searching XML with Nokogiri
  #https://nokogiri.org/tutorials/searching_a_xml_html_document.
  #http://ruby.bastardsbook.com/chapters/html-parsing/
  
  #Array of all the food banks: doc.css("Placemark")
  #Array of all the Food Bank names: doc.css("Placemark name") / doc.css("Placemark name").text / bank.css("name").text
  #Array of all the Food Bank addresses: doc.css("Placemark address") / doc.css("Placemark address").text / bank.css("address").text
  #...contact name: doc.css("Placemark ExtendedData Data[name='Contact']").text / bank.css("ExtendedData Data[name='Contact']").text
  #...phone: doc.css("Placemark ExtendedData Data[name='Phone']").text / bank.css("ExtendedData Data[name='Phone']").text - needs strip
  #...common values in program type: "Pantry"
  #...program type: bank.css("ExtendedData Data[name='Program Type']").text.strip
  #...address: bank.css("ExtendedData Data[name='ç']").text.strip
  #...city (borough): bank.css("ExtendedData Data[name='City']").text.strip
  #...state: bank.css("ExtendedData Data[name='State']").text.strip
  #...zip: bank.css("ExtendedData Data[name='ZIP Code']").text.strip
  #...common values in days: "-" "closed" "8:00 AM - 10:00 AM" "1:00 PM - 3:00 PM (By appointment only)"
  #...monday: bank.css("ExtendedData Data[name='Monday']").text.strip
  #...tuesday: bank.css("ExtendedData Data[name='Tuesday']").text.strip
  #...wednesday: bank.css("ExtendedData Data[name='Wednesday']").text.strip
  #...thursday: bank.css("ExtendedData Data[name='Thursday']").text.strip
  #...friday: bank.css("ExtendedData Data[name='Friday']").text.strip
  #...saturday: bank.css("ExtendedData Data[name='Saturday']").text.strip
  #...sunday: bank.css("ExtendedData Data[name='Sunday']").text.strip
  #page.css("li[data-category='news']")
  
  def self.scrape_banks(path)
    xml = File.read(path)
    doc = Nokogiri::XML(xml)  
    banks = []
    
    doc.css("Placemark").each_with_index do |bank, index|
      days = []
      days[0] = bank.css("ExtendedData Data[name='Sunday']").text.strip
      days[1] = bank.css("ExtendedData Data[name='Monday']").text.strip
      days[2] = bank.css("ExtendedData Data[name='Tuesday']").text.strip
      days[3] = bank.css("ExtendedData Data[name='Wednesday']").text.strip
      days[4] = bank.css("ExtendedData Data[name='Thursday']").text.strip
      days[5] = bank.css("ExtendedData Data[name='Friday']").text.strip
      days[6] = bank.css("ExtendedData Data[name='Saturday']").text.strip
      
      duplicate = false
      
      #Skip duplicate entries
      #if banks.detect { |x| (x[:name] == bank.css("name").text.strip) && (x[:program] == bank.css("ExtendedData Data[name='Program Type']").text.strip) && (x[:address] == bank.css("address").text.strip) }
        #duplicate = true 
      #end
      
      banks[index] = {
        :name => bank.css("name").text.strip,
        :address => bank.css("address").text.strip,
        :contact => bank.css("ExtendedData Data[name='Contact']").text.strip,
        :phone => bank.css("ExtendedData Data[name='Phone']").text.strip,
        :program => bank.css("ExtendedData Data[name='Program Type']").text.strip,
        #:address => bank.css("ExtendedData Data[name='Address']").text.strip,
        :city => bank.css("ExtendedData Data[name='City']").text.strip,
        :state => bank.css("ExtendedData Data[name='State']").text.strip,
        :zip => bank.css("ExtendedData Data[name='ZIP Code']").text.strip,
        :days => days,
        :distance => 0
      }
      
    end
    
    banks
    #binding.pry
    
  end
  
end