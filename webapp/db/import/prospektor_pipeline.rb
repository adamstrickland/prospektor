module ProspektorPipeline
  def self.included(base)
    base.extend(Helpers)
  end
  
  module Helpers
    def user_from_employee(emp_id, context)
      User.find_by_employee_id(emp_id).id
    end
  
    def phone_from_float(val, ctxt)
      val.to_i.to_s
    end
  
    def int_from_float(val, ctxt)
      val.to_i
    end
  
    def downcase(val, ctxt)
      val ? val.downcase == "own" : false
    end
  end
end