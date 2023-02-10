#
# test for script/generate_student_reports.rb
# to run from the root directory: `ruby test/generate_student_reports_test.rb`
#

require_relative "../lib/george.rb"
test_results = []

current_courses = George::Term.current.courses
current_sections = current_courses.map{|course| course.sections }.flatten
current_sections.each do |section|
  report_path = section.student_report_path
  pp report_path
  FileUtils.rm_f(report_path)

  section.generate_student_report

  test_results << (File.exist?(report_path) ?  true : false) # expect the report file to exist
  test_results << (IO.readlines(report_path).length >= 34 ? true : false) #todo: expect it to contain the expected number of students
end

put