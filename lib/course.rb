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