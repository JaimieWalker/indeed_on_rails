require 'open-uri'

class Api

  attr_reader :hash, :known_languages, :users_location

  def initialize(user_data)
    @known_languages = user_data["languages"]
    @users_location = user_data["location"]
    fetch
  end


  def self.jobs_data(user_data)
    api = Api.new(user_data)
    api.formatted_data
  end



  #######################################
  #"Core Logic"
  ####################################### 



  def formatted_data
    hash["results"].map do |job|

      paragraph = "A strong Report and Data Visualization Architect to be responsible for Actuarial BI architecture. Defining and building Enterprise business intelligence, working very closely and aligned to our data Integration and data strategy implementation.\n\nâ\u0080¢ Working with Actuarial business SMEâ\u0080\u0099s to understand reporting requirements\n\nâ\u0080¢ Designing and developing queries to support Actuarial reporting requirements\n\nâ\u0080¢ Performing detailed data analysis, data validation and identify data quality issues\n\nâ\u0080¢ Creating Ad-Hoc queries and reports as needed along with providing on-going analytical support for these requests\n\nâ\u0080¢ Tuning MicroStrategy queries to run efficiently in a large data volume environment\n\nâ\u0080¢ Train users on MicroStrategy reporting tool usage\n\nâ\u0080¢ Provide production support for MicroStrategy report users\n\nPosition Requirements\n\nâ\u0080¢ Strong written and oral communication skill\n\nâ\u0080¢ Excellent problem-solving and quantitative skills\n\nâ\u0080¢ 3-5 years of experience designing and tuning advanced MicroStrategy reports\n\nâ\u0080¢ 3-5 years of experience utilizing MicroStrategy for developing dynamic reports and dashboards\n\nâ\u0080¢ 3-5 years of experience designing and tuning advanced SQL queries\n\nâ\u0080¢ Experience developing large scale systems in a controlled development and testing environment\n\nâ\u0080¢ Ability to work utilizing Agile-Based methodologies (such as Extreme Programming and Scrum) within a Software development function\n\nâ\u0080¢ Ability to work well as part of a team in a high pressure, agile environment\n\nâ\u0080¢ Excellent data analysis and SQL skills\n\nDESIRED SKILLS / EXPERIENCE\n\nâ\u0080¢ Experience with Oracle preferred\n\nâ\u0080¢ Familiarity with standard development toolkits including source repositories (TFS), SQL Interpreters (TOAD), Visio\n\nâ\u0080¢ Solid work ethics, self-driven with the ability to work with minimal supervision\n\nâ\u0080¢ Excellent MS Office skills (Excel and PowerPoint)\n\nâ\u0080¢ Basic understanding of Actuarial pricing and reserving activities is a plus\n\nâ\u0080¢ Understanding of Capital Markets / Asset Management is a plus"#Scraper.new(job["url"]).fetch
      associated_languages = SkillGap.new(paragraph).find_languages


      job_hash = {
        :post => {
          job_title: job["jobtitle"],
          company: job["company"],
          formatted_location: job["formattedLocation"],
          date: job["date"],
          url: job["url"],
          description: paragraph
        },
        :languages => associated_languages
      }

    end
  end


  #######################################
  #"The API Call!"
  ####################################### 



  def fetch
    @hash = JSON.parse(File.read(open(api_url)))
  end



  #######################################
  #"API Fetch Helper Methods..."
  ####################################### 


  def api_url
    static ||= "http://api.indeed.com/ads/apisearch?publisher=3070567809660386&q="
    quary ||= "#{languages_encoding}&l=#{location_encoding}&sort="
    misc ||= "&radius=&st=&jt=&start=&limit=30&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2&format=json"
    "#{static}#{quary}#{misc}"
  end

  def location_encoding
    @location ||= users_location.gsub(",", "%2C").gsub(" ", "+")
  end

  def languages_encoding
    @languages ||= known_languages.gsub("#","%23").gsub("+", "%2B")
  end

end
