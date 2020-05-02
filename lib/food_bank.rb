require_relative "./food_bank/version"
require_relative './food_bank/cli'
require_relative './food_bank/scraper'
require_relative './food_bank/distance'

require 'pry'
require 'nokogiri'
require 'geokit'

module FoodBank
  class Error < StandardError; end
    #Your code here
  end