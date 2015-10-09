require 'open-uri'
class Scraper

  def self.description(url)
    @doc = Nokogiri::HTML(open(url)).css('table tr td.snip #job_summary').text
  end

end
