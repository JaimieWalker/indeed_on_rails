class SkillGap

  attr_reader :paragraph

  def initialize(description)
    @paragraph = description.gsub(".", "").gsub(",", "").gsub("/", "").downcase
  end

  @@language_hash ||= {
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

  @@language_keys ||= @@language_hash.keys


  def find_languages
    associated_languages = @@language_keys.select do |lang|
      paragraph.include?(lang)
    end
    @@language_hash.values_at(*associated_languages)
  end

  def speed_test(rounds)
    Benchmark.measure do 
      rounds.times { find_languages }
    end
  end

end