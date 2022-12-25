
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
###      @email_address = attributes[:email_address]
###      @degree = attributes[:degree]
###      @level = attributes[:level]
###      @program = attributes[:program]
###      @admit_term = attributes[:admit_term]
###      @admit_type = attributes[:admit_type]
###      @catalog_term = attributes[:catalog_term]
###      @college = attributes[:college]
###      @campus = attributes[:campus]
###      @majors = attributes[:major] || []
###      @minors = attributes[:minors] || []
###      @grad_class = attributes[:grad_class]
###      @credits  = attributes[:credits]
###    end
###
###    def net_id
###      email_address.gsub("@gwu.edu", "")
###    end
###  end
###end