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

Part two (mainly setting up the CLI):
https://www.youtube.com/watch?v=TaRZ9Z8dK2s&feature=emb_logo

00:09:46
Remember to run "bundle install" every time you re-open your project or none of the gems will work

Part three
https://www.youtube.com/watch?v=VMAW3VjPUPw&feature=emb_logo

00:24:33
Building a scraper

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
4. 

Borough names returned by Google:
* New York
* Brooklyn
* The Bronx
* Queens
* Staten Island

Try to remove duplicate entries and New York Common Pantry
Dupes - or can you auto-detect duplicates when showing top 5 - SEEMS BETTER: 
The Campaign Against Hunger
Masbia of Queens
Masbia of Boro Park

XXX Remove duplicates - maybe just don't even add it during scraping if it already exists (dupe shows at 2PM Tuesday 92-10 Atlantic Ave, Queens, NY 11416) - there's only two real duplicates and this code slows things down too much
XXX Consolidate time into one entry
XXX Colored text - 
* ..Possible colors: 
* :black,
 :light_black,
 :red,
 :light_red,
 :green,
 :light_green,
 :yellow,
 :light_yellow,
 :blue,
 :light_blue,
 :magenta,
 :light_magenta,
 :cyan,
 :light_cyan,
 :white,
 :light_white,
XXX Fix loading message
* Remove commenting
* Clean up code
* Catch the Google API exception
* Find better solution to re-generating .env file every time
* Multi-thread location search?
XXX Put full loop so they can search again, or exit completely
XXX Fix some time errors - if you search at 3:13PM Tuesday around 1005 Manhattan Ave, 11222 - it shows food banks that close at 3
XXX 'CCNS-St. Marks' causes problems:
XXX .. Thursday: 09:30 AM - 11:30 AM (1st and 3rd Thursday of the month)
XXX 'New York Common Pantry (Pantry & Soup Kitchen)' causes problems:
XXX .. Thursday: Soup Kitchen 08:00 AM - 09:30 AM & Pantry 10:00 AM - 02:30 PM