class Scraper

def url_scraper
descriptions = []
	Api.new.job_url.each do |url|
		@doc = Nokogiri::HTML(open('#{url}')).css('table tr td.snip #job_summary').text
		descriptions << simple_format(@doc)
	end
end
