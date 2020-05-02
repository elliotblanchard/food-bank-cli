# Our CLI Controller
class FoodBank::CLI
  BASE_PATH = "fixtures/Food_Bank_For_NYC_Open_Members_as_of_42820.kml"

  def initialize
    @address = {}
    @time = {}
    @user_address = ""
  end
  
  def call
    puts "Find open food banks near you in New York City."
    
    #FoodBank::Mapping.get_distance
    
    get_user_info          #collects user info
    make_banks             #scrapes data and creates bank objects
    list_banks(find_banks) #shows the matching banks
    
    #FoodBank::Scraper.scrape_banks
    #FoodBank::Mapping.get_distance
    #scraper = Scraper.new - scraper shouldn't be in the CLI
    #list_food_banks(banks,@address,@time)
  end
  
  def make_banks
    banks_array = FoodBank::Scraper.scrape_banks(BASE_PATH)
    FoodBank::Bank.create_from_collection(banks_array)
  end 
  
  def find_banks
    #Find matching food banks
    
    #Find food banks open at the right time
    same_time = FoodBank::Bank.find_by_time(@time)
    if same_time.length > 0
      banks_sorted = FoodBank::Mapping.get_distance(@user_address,same_time)
    end
    
    #banks_sorted.each do |bank|
    #  puts bank.distance
    #end
    
    banks_sorted
  end
  
  def get_user_info
    get_user_address
    get_user_day_time
  end
  
  def get_user_address
    #borough = ['Manhattan','Brooklyn','Queens','Bronx','Staten Island']
    input_correct = false
    input = ""
    
    until input_correct == true
      puts "\nWhat is your address? For example: '123 4th Avenue'"
      input = gets.strip
      if input != "" 
        input_correct = true
      end
    end
    
    @address[:street] = input
    
    input_correct = false
    
    until input_correct == true
      puts "\nWhat is your ZIP code? For example: '11231'"
      input = gets.strip
      input = input.to_i
      if input.to_s.length == 5
        input_correct = true
      end
    end
    
    @address[:zip] = input
    
    #until input > 0 && input < 6
    #  puts "\nEnter the number of your borough:"
    #  borough.each_with_index do |borough,index| 
    #    puts "#{index+1}. #{borough}"
    #  end      
    #  input = gets.strip
    #  input = input.to_i
    #end
    
    @user_address = @address[:street] + ", New York, NY, " + @address[:zip].to_s
    
    #validate address
    if FoodBank::Mapping.check_address(@user_address) == false
      puts "Can't find your address. Please try again."
      get_user_address
    else
      @address[:borough] = FoodBank::Mapping.check_address(@user_address) 
    end
  
  end
  
  def list_banks(banks)
    if banks.length > 0 
      puts "These are the 5 closest food banks open during your selected time:"
      for i in 0..4
        puts "#{i}. #{banks[i].name}, #{banks[i].distance.round(2)} miles."
      end
    else
      puts "No food banks matched your selected time."
    end
  end
      
  def get_user_day_time
    days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
    input = 0
    input_correct = false
    
    until input > 0 && input < 8
      #list the days
      puts "\nEnter the number of the day you are available:"
      days.each_with_index do |day,index| 
        puts "#{index+1}. #{day}"
      end
      input = gets.strip
      input = input.to_i
    end
    
    @time[:day] = input-1
    
    until input_correct == true
      #enter time
      puts "\nWhat time are you available? For example: '11:30'"
      input = gets.strip
      time_elements = input.split(":")
      if time_elements.length == 2 && (time_elements[0].to_i > 0 && time_elements[0].to_i < 13) && (time_elements[1].to_i > 0 && time_elements[1].to_i < 60)
        input_correct = true
      end
    end
    
    @time[:hour] = time_elements[0]
    @time[:minutes] = time_elements[1]
    
    input_correct = false
    
    until input_correct == true
      #enter AM / PM
      puts "\nAM or PM? For example 'AM'"
      input = gets.strip
      if input == "AM" || input == "PM"
        input_correct = true
      end
    end
    
    @time[:ampm] = input
    
  end
  
end
