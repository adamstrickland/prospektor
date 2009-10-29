class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.string :name
      t.string :last_name
      t.string :first_name
      t.string :salutation
      t.string :title
      t.string :gender, :limit => 1
      t.string :company
      t.integer :year_established
      t.string :address
      t.string :city
      t.string :state, :limit => 4
      t.string :county
      t.string :zip, :limit => 10
      t.string :phone, :limit => 10
      t.string :extension, :limit => 5
      t.string :fax, :limit => 10
      t.string :cell_phone, :limit => 10
      t.integer :employee_actual
      t.string :employee_code
      t.integer :sales_actual
      t.string :sales_code
      t.string :line_of_business
      (0..9).each do |i|
        t.string "sic_code_#{i}".to_sym
        t.string "sic_description_#{i}".to_sym
      end
      (0..4).each do |i|
        t.string "naics_code_#{i}".to_sym
        t.string "naics_description_#{i}".to_sym
      end
      t.string :msa
      t.string :web
      t.string :email
      t.integer :number_of_pcs
      t.integer :square_footage
      t.boolean :own_property
      t.string :credit_rating
      t.string :credit_rating_score
      t.integer :credit_numeric_score
      t.string :duns_number
      t.string :source
      t.timestamp :imported_at
      t.datetime :best_time_to_call
      t.string :timezone, :limit => 2
      t.string :sic_division
      t.string :sic_group_name
      (0..6).each do |i|
        t.text "question_#{i}".to_sym
      end
      (0..5).each do |i|
        t.boolean "request_hb_#{i}".to_sym
      end
      t.timestamps
    end
  end

  def self.down
    drop_table :leads
  end
end
