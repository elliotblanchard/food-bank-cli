require_relative "./food_bank/version"
require_relative './food_bank/cli'
require_relative './food_bank/scraper'

require 'pry'
require 'nokogiri'

module FoodBank
  class Error < StandardError; end
    #Your code here
  end