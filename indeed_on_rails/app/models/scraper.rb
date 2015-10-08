require 'open-uri'
class Scraper

  def self.description(url)
  	scraper = Scraper.new(url)
    scraper.formatted_text
  end

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def fetch
    @doc = Nokogiri::HTML(open(url)).css('table tr td.snip #job_summary').children
  end

  def to_text
    fetch.children.map {|e| e.text.gsub(/\n/, " ")}
  end

  def formatted_text
    to_text.join("@").gsub("@@", "").gsub("@", "\n")
  end

end
