class CreateAcsCodesTable < ActiveRecord::Migration
  def self.up
    create_table :acs_codes do |t|
      t.string :code
      t.string :description
    end
  end

  def self.down
    drop_table :acs_codes
  end
end
