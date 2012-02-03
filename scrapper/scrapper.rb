require 'rubygems'
require 'mechanize'
require 'logger'
require 'nokogiri'
require 'open-uri'

class RelatedImageScrapper
  
  GOOGLE_SEARCH_IMAGE_URI = "https://www.google.com/searchbyimage?image_url="

  def self.scrapp(uri)
    result = []
    a = Mechanize.new { |agent|
      agent.log = Logger.new(STDOUT)
      agent.user_agent_alias = 'Mac Safari'
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
      agent.ca_file = File.new("#{File.dirname(__FILE__)}/cacert.pem").path
    }

    a.get(GOOGLE_SEARCH_IMAGE_URI+uri) do |page|
     
      doc = Nokogiri::HTML(open("http://www.google.com#{page_r = page.link_with(:text => 'Visually similar').href}"))
      
      doc.xpath('//a[contains(@href,"imgurl")]').each do |line|
	line['href'].sub(/.+imgurl=(http.+)\&imgrefurl.+/) {result << $1}
      end
   end
   result
  end

end
