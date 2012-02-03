require 'test/unit'
require_relative "../scrapper/scrapper"
 
class ScrapperTest < Test::Unit::TestCase
  def testGetImagesSources
    result = RelatedImageScrapper.scrapp("http://www.terra.com.ar/imagenes/originales/198/198666.jpeg")
    assert result
    assert_equal 20, result.count
    result.each {|img| `wget #{img}`}
  end
end
