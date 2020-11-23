
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

### Prerequisites


Download **Detailed Class List**:

 1. Log in to GWeb.
 * Navigate to the *Faculty Menu*.
 * Choose *Detail Class List*.
 * Select a *Term*. Submit selection.
 * Select a *Course*. Submit selection.
 * View *Detail Class List*, and download source (html-only).

> Save as: terms/`:term_id`/courses/`:course_id`/sections/`:section_id`/downloads/class_details.html

## Contributing

To setup a development environment, install git, ruby, and bundler. Then clone this repository and install ruby package dependences:

```` sh
git clone git@github.com:gwu-business/george-lms.git
cd george-lms/
bundle install
````

### Testing

```` sh
ruby test/generate_student_reports_test.rb
````

## [License](LICENSE)