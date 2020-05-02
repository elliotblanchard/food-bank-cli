class FoodBank::Bank

  attr_accessor :name, :address, :contact, :phone, :program, :city, :state, :zip, :days

  @@all = []

  def initialize(bank_hash)
    bank_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(bank_array)
    bank_array.each { |bank| self.new(bank) }
  end

  #def add_student_attributes(attributes_hash)
  #  attributes_hash.each {|key, value| self.send(("#{key}="), value)}
  #  self
  #end

  def self.all
    @@all
  end
  
  #def find_by_borough(name)
  #  self.all.detect {|a| a.name == name}
  #end  
  
  def self.find_by_time(time_hash)
    binding.pry
    # Get food banks that are open on the correct day
    correct_day = self.all.select {|a| a.days[time_hash[:day]].include? "M"}
    
    # Create a time object from the user requested time
    user_time = create_time_object(time_hash)
    binding.pry
  end
  
  def self.create_time_object(time_hash)
    if time_hash[:ampm] == "AM"
      time = Time.new(2020, 1, 1, time_hash[:hour], time_hash[:minutes])
    else
      time = Time.new(2020, 1, 1, time_hash[:hour].to_i+12, time_hash[:minutes])
    end
    time
  end
  
end