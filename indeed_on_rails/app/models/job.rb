class Job < ActiveRecord::Base
	has_many :job_languages
	has_many :languages, through: :job_languages
end
