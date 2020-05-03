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

* Remove duplicates - maybe just don't even add it during scraping if it already exists (dupe shows at 2PM Tuesday 92-10 Atlantic Ave, Queens, NY 11416)
* Consolidate time into one entry
* Colored text
* Fix loading message
* Remove commenting
* Clean up code
* Catch the Google API exception