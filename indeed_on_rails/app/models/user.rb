class User < ActiveRecord::Base
	has_many :user_languages
	has_many :languages, through: :user_languages
	has_many :jobs, through: :languages

end
