Misc notes from Beth's Eden Project walkthough
https://www.youtube.com/watch?time_continue=13&v=KwBMwZ89Hj8&feature=emb_logo

00:09:56 if you simply want to see if nokogiri is getting data (HTML in her case)
site = "https://www.xyz.com"
doc = Nokogiri::HTML(open(site))
puts doc

00:15:05
The top level that contains all the food banks MAY be doc.css(".Folder")
Getting all the locations MAY be doc.css(".Folder.Placemark")

00:23:35
Setting up a GEM / project structure

00:29:04
Setting up a git repository

00:36:01
Setting up the project structure so you can run the project from ./bin etc 

00:46:00
Planning the program

01:15:00
How to correctly add dependencies (like Pry, Nokogiri, **and likely the location gem**) - and how to do 'bundle_install' correctly - all gems likely have to go in the gemspec file AND food_bank.rb

1. Flow
.1a. User is asked for address
.1b. User is asked for desired time / day of week
.1c. User sees 5 closest food banks
.1d. User selects food bank
.1e. User sees details of food bank

2. Classes
.2a. Foodbank - know about food banks
.2b. Scraper - gets the data
.2c. CLI - interacts with user

3. Class relationships