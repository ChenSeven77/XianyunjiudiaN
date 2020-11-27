module George
  class Course
    attr_accessor :term_id, :department_id, :id

    def initialize(attributes)
      @term_id = a