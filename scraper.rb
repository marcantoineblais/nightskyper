require 'open-uri'
require 'nokogiri'

# coordinates =
url = "https://clearoutside.com/forecast/45.48/-73.46"
selector = ".btn-bortle-8 strong:nth-child(3)"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

pp html_doc.search(selector).text.strip
