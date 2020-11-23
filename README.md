
# George LMS

A Learning Management System
 for assisting instructional operations
 of classes taught at the George Washington University.

Requires faculty access to the [GWeb Info System](https://banweb.gwu.edu).

Generates machine-readable class rosters and student detail reports.

## Usage

### Generate Student Report

```` sh
ruby script/generate_student_reports.rb
````

> This should produce a file for each course in the corresponding course directory: terms/`:term_id`/courses/`:course_id`/sections/`:section_id`/reports/students.csv
