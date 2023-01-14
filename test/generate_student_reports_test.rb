#
# test for script/generate_student_reports.rb
# to run from the root directory: `ruby test/generate_student_reports_test.rb`
#

require_relative "../lib/george.rb"
test_results = []

current_courses = George::Term.current.courses
current_sections = current_courses.map{|course| cou