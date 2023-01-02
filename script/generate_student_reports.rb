
#
# to run from the root directory: `ruby script/generate_student_reports.rb`
#

# Generate student report for each current course.

require_relative "../lib/george.rb"

current_courses = George::Term.current.courses
current_sections = current_courses.map{|course| course.sections }.flatten
current_sections.each do |section|
  section.generate_student_report
end