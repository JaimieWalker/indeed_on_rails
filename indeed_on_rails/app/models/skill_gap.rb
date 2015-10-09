class SkillGap #Returns array of languages, found in the description

  def initialize(paragraph)
    @paragraph = paragraph.gsub(".", "").gsub("/", "").gsub(".", "").downcase
  end

  attr_accessor :paragraph

  @@language_hash = {
    "java" => "Java",
    " c " => "C",
    "c++" => "C++",
    "c#" => "C#",
    "python" => "Python",
    "php" => "PHP",
    "visaul basic" => "Visaul Basic",
    "javascript" => "JavaScript",
    "perl" => "Perl",
    "ruby" => "Ruby",
    "assembly language" => "Assembly Language",
    "objective-c" => "Objective-C",
    "swift" => "Swift",
    "matlab" => "MATLAB",
    "sql" => "SQL",
    "pascal" => "Pascal",
    "openedge" => "OpenEdge",
    " r " => "R" 
  }

  @@language_keys = @@language_hash.keys


  def find_languages
    array = @@language_keys.select do |lang|
      paragraph.include?(lang)
    end
    @@language_hash.values_at(*array)
  end
end
