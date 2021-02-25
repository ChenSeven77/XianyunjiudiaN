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
    end

    def path
      File.join(TERMS_PATH, self.term_id, "courses", self.course_full_id, "sections", self.id)
    end

    #
    # HTML DOWNLOADS (INPUTS)
    #

    def downloads_path
      File.join(path, "downloads")
    end

    def download_class_summary_path
      File.join(downloads_path, "class_summary.html")
    end

    def download_class_details_path
      File.join(downloads_path, "class_details.html")
    end

    ###def download_student_addresses_path
    ###  File.join(downloads_path, "students", "addresses")
    ###end
###
    ###def download_student_transcripts_path
    ###  File.join(downloads_path, "students", "transcripts")
    ###end

    #
    # CSV REPORTS (OUTPUTS)
    #

    def reports_path
      File.join(path, "reports")
    end

    def enrollment_report_path
      File.join(reports_path, "enrollments.csv")
    end

    def student_report_path
      File.join(reports_path, "students.csv")
    end

    ###def student_address_report_path
    ###  File.join(reports_path, "student_addresses.csv")
    ###end
###
    ###def student_transcript_report_path
    ###  File.join(reports_path, "student_transcripts.csv")
    ###end












































    #
    # REPORT-GENERATION METHO