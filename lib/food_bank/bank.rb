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
end