class AddMoreSicsAndNaicsToLeads < ActiveRecord::Migration
  def self.up
    (6..10).each do |i|
      add_column :leads, "sic_code_#{i}".to_sym, :string
      add_column :leads, "sic_description_#{i}".to_sym, :string
    end
    (1..5).each do |i|
      add_column :leads, "naics_code_#{i}".to_sym, :string
      add_column :leads, "naics_description_#{i}".to_sym, :string
    end
  end

  def self.down
    (6..10).each do |i|
      remove_column :leads, "sic_code_#{i}".to_sym
      remove_column :leads, "sic_description_#{i}".to_sym
    end
    (1..5).each do |i|
      remove_column :leads, "naics_code_#{i}".to_sym
      remove_column :leads, "naics_description_#{i}".to_sym
    end
  end
end
