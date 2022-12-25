
###module George
###  class Student # or ... GWeb::Student
###    attr_accessor :record_number, :full_name, :gwid, :registration_status, :waitlist_position,
###      :notification_expires, :registration_number, :email_address,
###      :degree, :level, :program, :admit_term, :admit_type,
###      :catalog_term, :college, :campus, :majors, :minors, :grad_class, :credits
###
###    #serialize majors as Array
###    #serialize minors as Array
###
###    def initialize(attributes)
###      @record_number = attributes[:record_number]
###      @full_name = attributes[:full_name]
###      @gwid = attributes[:gwid]
###      @registration_status = attributes[:registration_status]
###      @waitlist_position = attributes[:waitlist_position]
###      @notification_expires = attributes[:notification_expires]
###      @registration_number = attributes[:registration_number]