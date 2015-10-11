require 'open-uri'
class Scraper

  def initialize(api_jobs)
    @api_jobs = api_jobs
    @header = {"Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", "Cache-Control" => "no-cache", "Pragma" => "no-cache", "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.168 Safari/535.19"}
    
    set_urls
    make_requests
  end

  attr_reader :api_jobs, :html_pages, :job_urls, :header


  ####################################################################
  # Returns all the descriptions from the job pages the api provided. 
  ####################################################################


  def self.descriptions(api_jobs)
    scraper = Scraper.new(api_jobs)

    scraper.html_pages.map do |page|
      @doc = Nokogiri::HTML(page).css('table tr td.snip #job_summary').text
    end
    
  end

  def set_urls 
    @job_urls = api_jobs.map {|job| job["url"]}
  end
  #####################################################################
  # Making http request in parrallal with the Typhoeus gem. Significantly reducing lag time. 
  # Returning the the html response into an array accessible 
  # to the html_pages method
  ######################################################################

  def make_requests
    hydra = Typhoeus::Hydra.new
    requests = api_jobs.count.times.map do |i|
      Typhoeus::Request.new(job_urls[i], headers: header, verbose: true, follow_location: true)
    end

    requests.each { |request| hydra.queue(request) }
    hydra.run

    @html_pages = requests.map {|job| job.response.response_body}
  end

end
