class SkillGap

  def initialize(paragraph, user)
    @paragraph = paragraph
    @user = user
  end

  attr_accessor :paragraph, :user

  @@language_hash = {
      "java" => "Java",
     " c" => "C",
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
      " r" => "R"
    }

  @@language_keys = @@language_hash.keys


  def find_languages
    array = @@language_keys.select do |lang|
      paragraph.include?(lang)
    end
    @@language_hash.values_at(*array)
  end

  def speed_test(rounds)
    Benchmark.measure do 
      rounds.times do 
        SkillGap.new("hello, c,", "zalman").find_languages
      end
    end
  end

end