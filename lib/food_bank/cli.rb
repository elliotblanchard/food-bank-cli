# Our CLI Controller
class FoodBank::CLI
  
  def initialize
    @address = {}
    @time = {}
  end
  
  def call
    puts "Find some open food banks near you in New York City."
    
    #get_user_address
    #get_user_day_time
    
    FoodBank::Scraper.scrape_banks
    
    #scraper = Scraper.new - scraper shouldn't be in the CLI
    
    #list_food_banks(banks,@address,@time)
    
    #binding.pry
  end
  
  def get_user_address
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
    
    #binding.pry
    
    #Is there a way to validate the address?
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
    
    @time[:day] = days[input-1]
    
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
