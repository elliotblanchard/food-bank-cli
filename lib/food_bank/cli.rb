# Our CLI Controller
class FoodBank::CLI
  BASE_PATH = "fixtures/Food_Bank_For_NYC_Open_Members_as_of_42820.kml"

  def initialize
    @address = {}
    @time = {}
    @user_address = ""
    @days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday']
  end
  
  def call
    # Main program loop
    
    make_banks #scrapes data and creates bank objects
    input = ""
    until input == "no"
      puts "Find open food banks near you in New York City."
      get_user_info          #collects user info
      list_banks(find_banks) #shows the matching banks
      print "Search again? Enter '"
      print "yes".colorize(:green)
      print "' or '"
      print "no".colorize(:red)
      print "'\n"
      input = gets.strip
    end
  end
  
  def make_banks
    # Calls the scraper to create an array of food bank hashes
    banks_array = FoodBank::Scraper.scrape_banks(BASE_PATH)
    
    # Uses that array of hashes to create object for each food bank
    FoodBank::Bank.create_from_collection(banks_array)
  end 
  
  def find_banks
    #Find food banks open at the right time
    same_time = FoodBank::Bank.find_by_time(@time)
    if same_time.length > 0
      # Get distance between the user and every food bank open at the right time / day
      banks_sorted = FoodBank::Mapping.get_distance(@user_address,same_time)
    end
    banks_sorted
  end
  
  def get_user_info
    # Collects data from user
    get_user_address
    get_user_day_time
  end
  
  def get_user_address 
    input_correct = false
    input = ""
    
    until input_correct == true
      print "\nWhat is your address? For example: '"
      print "123 4th Avenue".colorize(:light_blue)
      print "'\n"
      input = gets.strip
      if input != "" 
        input_correct = true
      end
    end
    
    @address[:street] = input
    
    input_correct = false
    
    until input_correct == true
      print "\nWhat is your ZIP code? For example: '"
      print "11231".colorize(:light_blue)
      print "'\n"
      input = gets.strip
      input = input.to_i
      if input.to_s.length == 5
        input_correct = true
      end
    end
    
    @address[:zip] = input
    
    @user_address = @address[:street] + ", New York, NY, " + @address[:zip].to_s
    
    #Validate address
    if FoodBank::Mapping.check_address(@user_address) == false
      print "\nCan't find your address.".colorize(:red) 
      print "Please try again.\n"
      get_user_address
    else
      @address[:borough] = FoodBank::Mapping.check_address(@user_address) 
    end
  
  end
  
  def list_banks(banks)
    # Lists the 5 closest food banks
    continue = true
    until continue == false
     if banks != nil
       print "\nHere are the 5 closest food banks open at "
       print "#{@time[:hour]}:#{@time[:minutes]} #{@time[:ampm]}".colorize(:light_blue) 
       print " on "
       print "#{@days[@time[:day]]}:\n".colorize(:light_blue)
        for i in 0..4
          if banks[i] != nil
            print "#{i+1}. #{banks[i].name}: "
            print "#{banks[i].program} ".colorize(:light_yellow)
            print "(#{banks[i].distance.round(2)} miles)\n".colorize(:yellow)
         end
       end
       puts "\nCall ahead to confirm hours."
       print "\nEnter a number for more info, '"
       print "all".colorize(:green)
       print "' for every food bank, or '"
       print "exit".colorize(:red)
       print "' if finished:\n"
       input = gets.strip
       if input == "exit"
         continue = false
       elsif input == "all"
         for k in 0..4
           print_banks(banks,k)
         end 
       elsif (input.to_i > 0) && (input.to_i < (banks.length + 1)) 
         print_banks(banks,input.to_i-1)
       else
         continue = false
       end
     else
        puts "No food banks match your selected time.".colorize(:red)
        continue = false
     end
    end
  end
  
  def print_banks(banks,index)
    # Prints detailed data on selected food banks
    #:name, :address, :contact, :phone, :program, :city, :state, :zip, :days, :distance
    if banks[index] != nil
      print "Name:".colorize(:yellow)
      print "     #{banks[index].name}\n"
      sleep(0.1)
      print "Address:".colorize(:yellow)
      print "  #{banks[index].address}\n"
      sleep(0.1)
      print "Type:".colorize(:yellow)
      print"     #{banks[index].program}\n"
      sleep(0.1)
      print "Phone:".colorize(:yellow)
      print "    #{banks[index].phone}\n"
      sleep(0.1)
      print "Contact:".colorize(:yellow)
      print "  #{banks[index].contact}\n"
      sleep(0.1)
      print "Distance:".colorize(:yellow)
      print " #{banks[index].distance.round(2)} miles\n"
      sleep(0.1)
      print "Hours: \n".colorize(:yellow)
      sleep(0.1)
      banks[index].days.each_with_index do |day, index|
        print "...#{@days[index]}: ".colorize(:yellow)
        print "#{day}\n"
        sleep(0.1)
      end
      puts "\n"
    end
  end
      
  def get_user_day_time
    input = 0
    input_correct = false
    
    until input > 0 && input < 8
      #list the days
      puts "\nEnter the number of the day you are available:"
      @days.each_with_index do |day,index| 
        puts "#{index+1}. #{day}"
      end
      input = gets.strip
      input = input.to_i
    end
    
    @time[:day] = input-1
    
    until input_correct == true
      #enter time
      print "\nWhat time are you available? For example: '"
      print "11:30 AM".colorize(:light_blue)
      print "'\n"
      input = gets.strip
      time_elements = input.split(":")
      minutes = time_elements[1][0,2]
      ampm = time_elements[1][3,5]
      if time_elements.length == 2 && (time_elements[0].to_i > 0 && time_elements[0].to_i < 13) && (minutes.to_i > -1 && minutes.to_i < 60) && (ampm == "AM" || ampm == "PM")
        input_correct = true
      end
    end
    
    @time[:hour] = time_elements[0]
    @time[:minutes] = minutes
    @time[:ampm] = ampm
    
  end
  
end
