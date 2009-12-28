require 'rio'

module SuperGenerator
  def self.generate(old_table_name, old_table_columns)
    # generate a migration for the table & the view
    # generate a mapper
    meta = metadata(old_table_name, old_table_columns)
    ts = Time.now.strftime('%Y%m%d%H%M%S')
    seq = "%03d" % rio(File.join(Rails.root, "db", "migrate")).files["#{ts}*.rb"].count
    migration_name = "#{ts}#{seq}_create_#{meta[:table][:to].to_s}.rb"
    migration_cols = meta[:columns].delete_if{|col| col[:to][:name] == :created_at }.map{|col| "t.#{col[:to][:type].to_s} :#{col[:to][:name].to_s}" }.concat(['t.timestamps'])
    
    mig = rio(File.join(Rails.root, "db", "migrate", migration_name))
    mig < ""
    mig << "class Create#{meta[:table][:to].to_s.camelize} < ActiveRecord::Migration\n"
    mig << "  def self.up\n"
    mig << "    create_table :#{meta[:table][:to]} do |t|\n"
    migration_cols.each do |mc|
      mig << "      #{mc}\n"
    end
      # {migration_cols.join('\n')}
    mig << "    end\n"
    mig << "    execute 'CREATE VIEW `#{meta[:table][:from]}` ( #{meta[:columns].map{|col| "`#{col[:from][:name]}`" }.join(',')}) AS SELECT #{meta[:columns].map{|col| col[:to][:name].to_s}.join(',')} FROM #{meta[:table][:to].to_s}'\n"
    mig << "  end\n"

    mig << "  def self.down\n"
    mig << "    execute 'DROP VIEW `#{meta[:table][:from]}`'\n"
    mig << "    drop_table :#{meta[:table][:to]}\n"
    mig << "  end\n"
    mig << "end"
    # EOF
    
    column_mappings = meta[:columns].map do |col|
      "'#{col[:from][:name]}' => { :to => :#{col[:to][:name]}}"
    end
    r = rio(File.join(Rails.root, "db", "import", "#{meta[:table][:to].to_s}_mapper.rb"))
    r < ""
    r << "class #{meta[:table][:to].to_s.camelize}Mapper < Pipeline::TransformMapper\n"
    r << "  define_mappings({\n"
    column_mappings.each do |cm|
      r << "    #{cm},\n"
    end
    r << "  })\n"
    r << "end"
  # define_mappings({
  #   #{column_mappings.join(',')}
  # })
# end
#     EOF
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