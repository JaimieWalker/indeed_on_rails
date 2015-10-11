require 'open-uri'

class Api 

  def self.create_jobs(user_object)
     
    api = Api.new(user_object)
    api.fetch

   
    job_descriptions = Scraper.descriptions(api.hash["results"])
    

    api.hash["results"].each_with_index do |job, index|

      job_hash = {
        job_title: job["jobtitle"],
        company: job["company"],
        formatted_location: job["formattedLocation"],
        date: job["date"],
        url: job["url"],
        description: job_descriptions[index]
      }

      @job = Job.create(job_hash)

      @languages = SkillGap.new(job_descriptions[index]).find_languages

      @languages.each do |lang|
        @job.languages << Language.find_or_create_by(name: lang)
      end

      @job.save
    
    end
    
  end

  attr_accessor :user
  attr_reader :hash

  def initialize(user_object) 
    @user = user_object
  end

  def fetch
    @hash = JSON.parse(File.read(open(api_url)))
  end

  def api_url
    static = "http://api.indeed.com/ads/apisearch?publisher=3070567809660386&q="
    quary = "#{languages}&l=#{location}&sort="
    misc = "&radius=&st=&jt=&start=&limit=30&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2&format=json"
    "#{static}#{quary}#{misc}"
  end

  def location 
    @location = user.location.gsub(",", "%2C").gsub(" ", "+")
  end

  def languages
    @languages = user.languages.map do |lang| 
      lang.name.gsub("#","%23").gsub("+", "%2B")
    end

    result = @languages.join("%2C+").gsub(" ", "+")
  end

end