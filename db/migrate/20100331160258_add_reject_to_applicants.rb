class AddRejectToApplicants < ActiveRecord::Migration
  def self.up
    add_column :applicants, :rejected, :boolean, :default => false
    
    Applicant.reset_column_information
    
    Applicant.all.each do |a|
      unless a.applicantdispositionstatus.blank? or a.applicantdispositionstatus == 'Hired - applicant accepted offer' or a.applicantdispositionstatus == 'HIRED'
        a.rejected = true
        a.save
      end
    end
    
    remove_column :applicants, :applicantdispositionstatus
  end

  def self.down
    add_column :applicants, :applicantdispositionstatus
    
    Applicant.reset_column_information
    
    Applicant.all.each do |a|
      a.applicantdispositionstatus = a.rejected? ? 'REJECTED' : 'HIRED'
    end
    
    remove_column :applicants, :rejected
  end
end
