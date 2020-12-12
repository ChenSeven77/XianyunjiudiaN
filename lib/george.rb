
require 'pry'
require 'json'
require 'nokogiri'
require 'csv'
require 'fileutils'
#require 'active_support/core_ext/object/try'

require_relative "term.rb"
require_relative "course.rb"
require_relative "section.rb"
require_relative "student.rb"

module George
  TERMS_PATH = File.expand_path("../../terms", __FILE__)
end