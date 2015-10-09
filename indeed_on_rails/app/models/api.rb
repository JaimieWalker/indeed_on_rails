require 'open-uri'

class Api
  attr_accessor :my_languages
  attr_reader :hash

  def initialize(language_string,location)
    @my_languages = language_string
    @my_location = location
    @hash = JSON.load(open(api_url))  
  end

  def api_url
    #This is where figora would be
    static = "http://api.indeed.com/ads/apisearch?publisher=3070567809660386&q="
    query = "#{languages}&l=#{location}&sort="
    misc = "&radius=&st=&jt=&start=&limit=30&fromage=&filter=&latlong=1&co=us&chnl=&userip&useragent&format=json&v=2"
    "#{static}#{query}#{misc}"
  end

  def location
    @my_location.gsub(",", "%2C").gsub(" ", "+")
    
  end

  def languages
      my_languages.gsub("#","%23").gsub("+", "%2B").gsub(" ", "+").gsub(",","%2C+")
  end

  def create_job
    
    hash["results"].each do |job|
      
      job_hash = {
        job_title: job["jobtitle"],
        company: job["company"],
        formatted_location: job["formattedLocation"],
        date: job["date"],
        url: job["url"],
        description: Scraper.description(job["url"])
      }
      @job = Job.create(job_hash)
    end
  end
end
