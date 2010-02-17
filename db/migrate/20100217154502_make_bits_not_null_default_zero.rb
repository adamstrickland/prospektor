class MakeBitsNotNullDefaultZero < ActiveRecord::Migration
  def self.up
    [
      :appliedtrigonbefore, 
      :currentlyemployed,
      :employercontactpermission,
      :hsinternetconnection,
      (1..4).map{|i| "edhistgraduated#{i}".to_sym },
      :icwa_received,
      :resume_received
    ].flatten.each do |col|
      change_column :applicants, col, :boolean, :default => false
    end
    
    [
      :w_2, :married, :active, :emp_ap, :i_9_form, :i_9_i_ds, :liability_insurance, :w_4_form,
      :policy_signoff, :ewa, :w_9, :business_proof
    ].flatten.each do |col|
      change_column :employees, col, :boolean, :default => false
    end
  end

  def self.down
  end
end
