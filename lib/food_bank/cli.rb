# Our CLI Controller
class FoodBank::CLI
  @time = {}
  @address = {}
  
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
    
    #list the days
    puts "\nEnter the number of the day you are available:"
    days.each_with_index do |day,index| 
      puts "#{index+1}. #{day}"
    end
    
  end
  
end
