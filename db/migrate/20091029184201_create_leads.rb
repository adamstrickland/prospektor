class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads do |t|
      t.string :name, :null => false
      t.string :last_name
      t.string :first_name
      t.string :salutation
      t.string :title
      t.string :gender, :limit => 1
      t.string :company, :null => false
      t.integer :year_established
      t.string :address
      t.string :city
      t.string :state, :limit => 4
      t.string :county
      t.string :zip, :limit => 10
      t.string :phone, :limit => 10, :null => false
      t.string :extension, :limit => 5
      t.string :fax, :limit => 10
      t.string :cell_phone, :limit => 10
      t.integer :employee_actual
      t.string :employee_code
      t.integer :sales_actual
      t.string :sales_code
      (1..5).each do |i|
        t.string "sic_code_#{i}".to_sym
        t.string "sic_description_#{i}".to_sym
      end
      t.string :msa
      t.string :web
      t.string :email
      t.integer :number_of_pcs
      t.integer :square_footage
      t.boolean :own_property
      t.string :credit_rating
      t.integer :credit_score
      t.string :source
      t.timestamp :imported_at
      t.string :timezone, :limit => 2
      t.timestamps
      
      t.index :phone, :unique => true
      t.index :name
      t.index :company
      t.index :state
      t.index :timezone
    end
  end

  def self.down
    drop_table :leads
  end
end
