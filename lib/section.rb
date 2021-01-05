module George
  class Section
    attr_accessor :id, :department_id, :course_id, :term_id

    def initialize(attributes)
      @term_id = attributes[:term_id]
      @department_id = attributes[:department_id]
      @course_id = attributes[:course_id]
      @id = attributes[:id]
    end

    def schedule_url
      "http://my.gwu.edu/mod/pws/courses.cfm?campId=1&termId=#{self.term_id}&subjId=#{self.department_id}"
    end

    def required_materials_url
      "http://www.bkstr.com/webapp/wcs/stores/servlet/booklookServlet?bookstore_id-1=122&term_id-1=#{self.term_id}&div-1=&dept-1=#{self.department_id}&course-1=#{self.course_id}&section-1=#{self.id}"
    end

    def course_full_id
      "#{self.department_id}-#{self.course_id}"
    en