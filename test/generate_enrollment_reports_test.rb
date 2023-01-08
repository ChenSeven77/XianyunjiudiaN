
#
# test for script/generate_enrollment_reports.rb
# to run from the root directory: `ruby test/generate_enrollment_reports_test.rb`
#

require_relative "../lib/george.rb"

istm4121_enrollment_report_path = File.join(George::TERMS_PATH, "201503", "courses", "istm-4121", "sections", "10", "reports", "enrollments.csv")

pp istm4121_enrollment_report_path

FileUtils.rm_f(istm4121_enrollment_report_path)

system "ruby script/generate_enrollment_reports.rb"

passes_test = File.exist?(istm4121_enrollment_report_path)

puts "TEST PASSES? -- #{passes_test}"