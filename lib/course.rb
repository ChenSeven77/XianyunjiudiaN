module George
  class Course
    attr_accessor :term_id, :department_id, :id

    def initialize(attributes)
      @term_id = attributes[:term_id] # 201503
      @department_id = attributes[:department_id] # ISTM
      @id = attributes[:id] # 4121
    end

    def full_id
      "#{department_id}-#{id}" # ISTM-4121
    end

    def bulletin_description_url
      "http://bulletin.gwu.edu/search/?P=#{department_id}+#{id}"
    end

    def path
      File.join(TERMS_PATH, self.term_id, "courses", self.full_id)
    end

    def sections_path
      File.join(self.path, "sections")
    end

    def sections_dir
      Dir.new(self.sections_path)
    end

    def section_ids
      self.sections_dir.entries.reject{|t| t.include?(".")} # converts [".", "..", "10", "11"] to ["10", "11"]
    end

    def sections
      self.section_ids.map do |section_id|
        s