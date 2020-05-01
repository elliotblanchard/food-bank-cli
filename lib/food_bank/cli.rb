# Our CLI Controller
class FoodBank::CLI
  
  def initialize
    @time = {}
    @address = {}
  end
  
  def call
    puts "Find some open food banks near you in New York City."
    
    #get_user_address
    
    get_user_day_time
    
    #get_food_banks(address,time)
    
    #list_food_banks
    
    #binding.pry
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
    
    @time[:AMPM] = input
    
    binding.pry
    
  end
  
end
