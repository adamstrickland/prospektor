require 'active_record'

module Mockingbird
  module CustomValidations
    def validates_email(*attr_names)
      attr_names.each do |attr_name|
        # could/should use Authentication.email_regex?
        options = {}
        options[:with] ||= /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
        options[:message] ||= "must be a valid email address"
        options[:allow_nil] ||= true
        validates_format_of attr_name, options
      end
    end
  end
end

ActiveRecord::Base.extend(Mockingbird::CustomValidations)