class FoodBank::Bank

  attr_accessor :name, :address, :contact, :phone, :program, :city, :state, :zip, :days, :distance

  @@all = []

  def initialize(bank_hash)
    bank_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(bank_array)
    bank_array.each { |bank| self.new(bank) }
  end

  def self.all
    @@all
  end
  
  def self.find_by_time(time_hash)
    # Get food banks that are open on the correct day
    correct_day = self.all.select {|a| a.days[time_hash[:day]].include? "M"}
    
    # Create a time object from the user requested time
    user_time = create_time_object(time_hash)
    
    correct_time = []
    
    correct_day.each do |bank| 
      time_raw = bank.days[time_hash[:day]].split("-")
      start_time_raw = time_raw[0].split(":")
      start_time_raw[0] = start_time_raw[0].scan(/\d/).join('') #only take digits
      end_time_raw = time_raw[1].split(":")
      end_time_raw[1] = end_time_raw[1][0,5] #Trim edge case data
      
      bank_time_start_hash = {
        :day => 0, 
        :hour => start_time_raw[0].strip.to_i, 
        :minutes => start_time_raw[1].strip[0,2].to_i, 
        :ampm => start_time_raw[1].strip[-2..]
      }
      
      bank_time_end_hash = {
        :day => 0, 
        :hour => end_time_raw[0].strip.to_i, 
        :minutes => end_time_raw[1].strip[0,2].to_i, 
        :ampm => end_time_raw[1][end_time_raw[1].index("M")-1,end_time_raw[1].index("M")]
      }

      bank_time_start = create_time_object(bank_time_start_hash)
      bank_time_end = create_time_object(bank_time_end_hash)
      
      #Checking if the user's time is in the open hours of the food bank
      range = bank_time_start..bank_time_end
      if range === user_time 
        correct_time << bank
      end
    end
    correct_time
  end
  
  def self.create_time_object(time_hash)
    if time_hash[:ampm] == "AM"
      time = Time.new(2020, 1, 1, time_hash[:hour], time_hash[:minutes])
    else
      if time_hash[:hour].to_i == 12
        adjusted_hour = 13
      else 
        adjusted_hour = time_hash[:hour].to_i+12
      end
      time = Time.new(2020, 1, 1, adjusted_hour, time_hash[:minutes])
    end
    time
  end
  
end