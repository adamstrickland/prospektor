module ResponseSetExtensions
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      # Same as typing in the class
      belongs_to :lead
    end
  end
  
  module ClassMethods
  end
  
  module InstanceMethods
    def has_lead?
      self.lead.present?
    end
  end
end

# Add module to ResponseSet
ResponseSet.send(:include, ResponseSetExtensions)