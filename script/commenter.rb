require 'fastercsv'
require 'active_support'

class Commenter
  def initialize(opts={})
    @employees = {}
  end
  
  def check_or_find(key, &block)
    if @employees.has_key?(key)
      @employees[key]
    else
      e = yield
      if e
        @employees[key] = e
      end
      e
    end
  end
  
  def find_employee_by_id(id)
    e = check_or_find(id){ Employee.find_by_id(id) }
  end
  
  def find_employee_by_name(name)
    e = check_or_find(name){ Employee.find_by_last_name(name) || Employee.find_by_username(name) }
  end

  def get_user(row)  
    e = nil
    rep_id = row['RepID']
    if rep_id and not rep_id.strip.empty?
      e = self.find_employee_by_id(rep_id)
    else
      rep_name = row['RepName']
      if rep_name and not rep_name.strip.empty?
        e = self.find_employee_by_name(rep_name)
      end
    end
    
    return (e ? e.user : nil)
  end

  def gogogo
    FasterCSV.foreach(File.join(Rails.root, '..', 'data', 'leads.csv'), :headers => :first_row) do |row|
      begin
        text = row['LastRepAppptComments']
        if text and not text.strip.blank?
	  text = text.strip
          phone = row['Phone'].strip.to_i.to_s
          lead = Lead.find_by_phone(phone)
          if lead
            user = self.get_user(row)
            comment = Comment.new(:lead => lead, :user => user, :comment => text)
            if comment.save
            else
              puts "Could not create comment for lead:  #{lead.id}"
            end
          end
        end
      rescue FasterCSV::MalformedCSVError
	puts "Failed at line #{csv.lineno}"
        # puts "Malformed Line at #{row['Phone']}"
      end
    end
  end

end