require 'rio'

module SuperGenerator
  def self.generate(old_table_name, old_table_columns)
    # generate a migration for the table & the view
    # generate a mapper
    meta = metadata(old_table_name, old_table_columns)
    migration_name = "#{Time.now.strftime('%Y%m%d%H%M%S')}_create_#{meta[:table][:to].to_s}.rb"
    migration_cols = meta[:columns].delete_if{|col| col[:to][:name] == :updated_at }.map{|col| "t.#{col[:to][:type].to_s} :#{col[:to][:name].to_s}" }.concat(['t.timestamps'])
    
    rio(File.join(Rails.root, "db", "migrate", migration_name)) < <<-EOF
class Create#{meta[:table][:to].to_s.titleize} < ActiveRecord::Migration
  def self.up
    create_table :#{meta[:table][:to]} do |t|
      #{migration_cols.join('\n')}
    end
    execute 'CREATE VIEW #{meta[:table][:from]} ( #{meta[:columns].map{|col| col[:from][:name]}.join(',')}) AS SELECT #{meta[:columns].map{|col| col[:to][:name].to_s}.join(',')} FROM #{meta[:table][:to].to_s}'
  end

  def self.down
    execute 'DROP VIEW #{meta[:table][:from]}'
    drop_table :#{meta[:table][:to]}
  end
end
    EOF
    
    column_mappings = meta[:columns].map do |col|
      "'#{col[:from][:name]}' => { :to => :#{col[:to][:name]}}"
    end
    rio(File.join(Rails.root, "db", "import", "#{meta[:table][:to].to_s}_mapper.rb")) < <<-EOF
class #{meta[:table][:to].to_s.titleize}Mapper < Pipeline::TransformMapper
  define_mappings({
    #{column_mappings.join(',')}
  })
end
    EOF
  end
  
  def self.metadata(old_table_name, old_table_columns)
    new_table_name = old_table_name.gsub(/\s/, '_').tableize.to_sym
    new_table_columns = old_table_columns.map do |c| 
      case c
      when "#{old_table_name.gsub(/\s/, '_')}ID", "#{old_table_name.gsub(/\s/, '_').singularize}ID" then :id
      when "SSMA_TimeStamp" then :created_at
      else c.gsub(/\s/, '_').underscore.to_sym
      end
    end
    new_table_types = new_table_columns.map do |c|
      case c.to_s
      when /.*id.*/ then :integer
      when /.*date.*/, /.*time.*/, /.*at$/ then :datetime
      when /.*amount.*/, /.*volume.*/, /.*rate.*/ then :float
      else :string
      end
    end
    
    {
      :table => {
        :from => old_table_name,
        :to => new_table_name
      },
      :columns => old_table_columns.map do |col|
        i = old_table_columns.index(col)
        {
          :from => { :name => col },
          :to => { 
            :name => new_table_columns[i], 
            :type => new_table_types[i]
          }
        }
      end
    }
  end
end