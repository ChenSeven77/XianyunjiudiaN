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
    # REPORT-GENERATION METHODS
    #

    def generate_enrollment_report
      puts "GENERATING ENROLLMENT REPORT (ROSTER) FOR SECTION #{self.inspect}"

      FileUtils.rm_f(enrollment_report_path)

      @enrollments = self.enrollments

      CSV.open(enrollment_report_path, "w", :write_headers=> true, :headers => @enrollments.first.keys.map{|k| k.to_s}) do |csv|
        @enrollments.each do |enrollment_attributes|
          csv << enrollment_attributes.values
        end
      end
    end

    def generate_student_report
      puts "GENERATING STUDENT REPORT FOR SECTION #{self.inspect}"

      FileUtils.rm_f(student_report_path)

      @students = self.students

      CSV.open(student_report_path, "w", :write_headers=> true, :headers => @students.first.keys.map{|k| k.to_s}) do |csv|
        @students.each do |student_attributes|
          csv << student_attributes.values
        end
      end
    end

    ###def generate_student_address_report
    ###  puts "GENERATING STUDENT ADDRESS REPORT FOR SECTION #{self.inspect}"
###
    ###  FileUtils.rm_f(student_address_report_path)
###
    ###  @student_addresses = self.student_addresses
###
    ###  CSV.open(student_address_report_path, "w", :write_headers=> true, :headers => @student_addresses.first.keys.map{|k| k.to_s}) do |csv|
    ###    @student_addresses.each do |student_address_attributes|
    ###      csv << student_address_attributes.values
    ###    end
    ###  end
    ###end

















    # deprecated because #students gets all this info and more from the "detail report"
    def enrollments

      #
      # Get Data Table(s)
      #

      document = Nokogiri::HTML(open(download_class_summary_path))
      tables = document.css("table")
      data_tables = tables.select{|t| t.attributes["class"] && t.attributes["class"].value == "datadisplaytable"}
      #course_summary_table     = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays the attributes of the course." }
      #enrollment_summary_table = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays enrollment and waitlist counts." }
      enrollments_table         = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays a list of students registered for the course; summary information about each student is provided." }

      #
      # Parse Course Summary Table
      #

      # todo

      #
      # Parse Enrollment Summary Table
      #

      # todo

      #
      # Parse Enrollments Table
      #

      enrollments = []

      enrollment_rows = enrollments_table.css("tr")

      enrollment_rows.each_with_index do |enrollment, index|
        next if index == 0 # ... skip the first row (headers) where enrollment.content == "\nRecordNumber\nWaitlist Position\nStudent Name\nID\nReg Status\nLevel\nCredits\nNotification Expires\n \n"

        # Get email link

        email_link = enrollment.css("a").find{|a| a.attributes["href"].value.include?("mailto:") }

        # Parse email link

        student_email_address = email_link.attributes["href"].value.gsub("mailto:","") #net_id = email_address.gsub("@gwu.edu")
        #student_net_id = student_email_address.gsub("@gwu.edu","")
        student_full_name = email_link.attributes["target"].value

        # Get table values

        attribute_values = enrollment.children.text.strip.split("\n")

        # Parse table values

        record_number = attribute_values[0]
        waitlist_position = attribute_values[1]
        #student_name = attribute_values[2].strip
        student_gwid = attribute_values[3]
        registration_status = attribute_values[4].gsub("**","")
        level = attribute_values[5]
        credits = attribute_values[6].strip
        #binding.pry
        notification_expires = attribute_values[7].strip

        #first_name_middle_initial = student_name.split(",").last.strip
        #last_name = student_name.split(",").first.strip

        # Transform.

        enrollment_attributes = {
          :id => record_number,
          :waitlist_position => waitlist_position,
          :student_gwid => student_gwid,
          :student_email_address => student_email_address,
          :student_full_name => student_full_name,
          :registration_status => registration_status,
          :student_level => level,
          :credits => credits,
          :notification_expires => notification_expires
        }

        enrollments << enrollment_attributes
      end

      return enrollments
    end














    def students

      #
      # Get Data Table(s)
      #

      document = Nokogiri::HTML(open(download_class_details_path))
      tables = document.css("table")
      data_tables = tables.select{|t| t.attributes["class"] && t.attributes["class"].value == "datadisplaytable"}
      #course_summary_table = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays the attributes of the course." }
      #enrollment_summary_table = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays enrollment and waitlist counts." }
      students_table = data_tables.find{|t| t.attributes["summary"] && t.attributes["summary"].value == "This table displays a list of students registered for the course; detailed information about each student is provided." }

      #
      # Parse Course Summary Table
      #
      # todo

      #
      # Parse Enrollment Summary Table
      #
      # todo

      #
      # Parse Students Table
      #

      students = []
      student = {:majors => [], :minors => [], :program => nil}
      #student = George::Student.new({})
      #student = {}
      student_id = 1
      summary_next = false
      degree_next = false
      save_next = false
      rows = students_table.css("tr")
      rows.each_with_index do |row, index|
        if row.content == "\nRecordNumber\nStudent Name\nID\nRegistration Status\nWaitlist Position\nNotification Expires\nRegistration Number\n \n"
          pp "-----------------"
  