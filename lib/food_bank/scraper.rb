#Misc notes from Beth's Eden Project walkthough
#https://www.youtube.com/watch?time_continue=13&v=KwBMwZ89Hj8&feature=emb_logo
#
#00:09:56 if you simply want to see if nokogiri is getting data (HTML in her case)
# site = "https://www.xyz.com"
# doc = Nokogiri::HTML(open(site))
# puts doc
#
#00:15:05
#The top level that contains all the food banks MAY be doc.css(".Folder")
#Getting all the locations MAY be doc.css(".Folder.Placemark")

require 'nokogiri'
require 'open-uri' #is this needed for an XML file?
