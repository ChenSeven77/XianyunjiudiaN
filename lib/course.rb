module George
  class Course
    attr_accessor :term_id, :department_id, :id

    def initialize(attributes)
      @term_id = attributes[:term_id] # 201503
      @department_id = attributes[:department_