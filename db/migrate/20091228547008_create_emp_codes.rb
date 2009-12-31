class CreateEmpCodes < ActiveRecord::Migration
  def self.up
    create_table :emp_codes do |t|
      t.string :emp_code
      t.string :employee_size
      t.string :ref_usa_employee_size
      t.timestamps
    end
    execute 'CREATE VIEW `Emp Codes` ( `Emp Code`,`Employee Size`,`RefUSA Employee Size`) AS SELECT emp_code,employee_size,ref_usa_employee_size FROM emp_codes'
  end
  def self.down
    execute 'DROP VIEW `Emp Codes`'
    drop_table :emp_codes
  end
end