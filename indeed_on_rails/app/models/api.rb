require 'open-uri'

class Api 

  attr_accessor :user
  attr_reader :hash

  def call(user_name)
    @user = User.find_by(name: user_name)
    fetch
    binding.pry
  end

  def fetch
    @hash = JSON.parse(File.read(open(url)))
  end

  def url
    static ||= "http://api.indeed.com/ads/apisearch?publisher=3070567809660386&q="
    quary ||= "#{languages}&l=#{location}&sort="
    misc ||= "&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2&format=json"
    "#{static}#{quary}#{misc}"
  end

  def location 
    @location ||= user.location.gsub(",", "%2C").gsub(" ", "+")
  end

  def languages
    @languages ||= user.languages.map do |lang| 
      lang.name.gsub("#","%23").gsub("+", "%2B")
    end

    result ||= @languages.join("%2C+").gsub(" ", "+")
  end


  def job_url
    job_array = []
    hash["results"].each do |whatever|
      job_array << whatever["url"]
    end
    job_array
  end

end