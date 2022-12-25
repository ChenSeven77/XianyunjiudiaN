
module George
  class Term
    attr_accessor :id, :name, :start_date, :end_date, :tentative_finals_schedule_url

    def initialize(attributes)
      @id = attributes[:id]
      @name = attributes[:name]
      @start_date = attributes[:start_date]
      @end_date = attributes[:start_date]
      @tentative_finals_schedule_url = attributes[:tentative_finals_schedule_url]
    end

    def self.current
      terms_dir = Dir.new(TERMS_PATH)
      term_ids = terms_dir.entries.reject{|t| t.include?(".")} # converts [".", "..", "201502", "201503"] to ["201502", "201503"]
      term_ids = term_ids.sort #.sort_by(&:to_i) # sorts in ascending order
      term_id = term_ids.last
      term_file = File.join(TERMS_PATH, term_id, "term.json")
      term_file_contents = File.read(term_file)
      term_attributes = JSON.parse(term_file_contents, :symbolize_names => true)
      Term.new(term_attributes)
    end

    def courses_path
      File.join(TERMS_PATH, self.id, "courses")
    end

    def courses_dir
      Dir.new(self.courses_path)
    end

    def course_ids