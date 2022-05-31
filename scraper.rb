require 'open-uri'
require 'nokogiri'

# coordinates =
url = "https://clearoutside.com/forecast//45.38/-73.50"
selector = "span[class*=btn-bortle] strong:nth-child(3)"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML(html_file)

pp html_doc.css(selector).text.strip
