module InMigrate
  class State < ActiveRecord::Base
    set_table_name 'states'
    belongs_to :time_zone, :class_name => 'InMigrate::TimeZone'
  end
  
  class TimeZone < ActiveRecord::Base
    set_table_name 'time_zones'
    has_many :states, :class_name => 'InMigrate::State'
  end
end

class AddTimeZoneToStates < ActiveRecord::Migration
  def self.up
    change_column :states, :state, :string, :length => 2, :null => false
    change_column :states, :state_name, :string, :null => false
    add_column :states, :time_zone_id, :integer
    
    State.reset_column_information
    
    {
      :e => [:me, :vt, :nh, :ma, :ri, :ct, :ny, :nj, :pa, :md, :de, :dc, :va, :wv, :oh, :mi, :in, :ky, :nc, :sc, :ga, :fl],
      :c => [:wi, :il, :tn, :al, :mi, :la, :tx, :ak, :ok, :mo, :ks, :ia, :ne, :mn, :nd, :sd],
      :m => [:nm, :co, :wy, :mt, :id, :ut, :az],
      :p => [:wa, :or, :nv, :ca],
      :a => [:ak],
      :h => [:hi]  
    }.each do |k, v|
      tz = TimeZone.find_by_time_zone(k.to_s.upcase)
      puts "Assigning states for timezone #{tz.name}:"
      v.map do |s| 
        State.find_by_state(s.to_s.upcase)
      end.each do |s|
        puts "\t#{s.abbrev}"
        s.time_zone = tz
        s.save
      end
    end
    
    change_column :states, :time_zone_id, :integer, :null => false
    add_index :states, :time_zone_id
  end

  def self.down
    remove_column :states, :time_zone_id
  end
end
