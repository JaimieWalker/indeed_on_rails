class JobLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :job
end
