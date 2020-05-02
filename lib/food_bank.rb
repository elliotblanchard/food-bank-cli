require_relative "./food_bank/version"
require_relative './food_bank/cli'
require_relative './food_bank/scraper'
require_relative './food_bank/mapping'
require_relative './food_bank/bank'

require 'pry'
require 'nokogiri'
require 'geokit'
require 'dotenv'


module FoodBank
  class Error < StandardError; end
    #Your code here
  end