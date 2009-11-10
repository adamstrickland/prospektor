require 'fastercsv'
require 'active_support'
require(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'boot'))
require(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'environment'))

module Pipeline
# TODO: support combining source records
# TODO: support filters/guards
# TODO: support pre- and post-processing
  class Importer
    @@default_import_dir = File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'db', 'import')
    
    def self.import_delimited(dir=@@default_import_dir, options={})
      puts "Importing data from #{dir}" if options[:verbose]
      options[:delimiter] ||= "\t"
      input_files = Dir.glob(File.join(dir, "*.txt"))
      puts "Input files: #{'['+input_files.join(', ')+']'}" if options[:verbose]
      input_files.each do |path|
        puts "  Loading file #{path}" if options[:verbose]
        
        table_name = File.basename(path, ".txt")
        model = Object.const_get("#{table_name.singularize.camelcase}")
        puts "    Loading file to table #{table_name} with model #{model}" if options[:verbose]
        
        mapping_files = Dir.glob(File.join(dir, "#{table_name}_mapper.rb"))
        if mapping_files and mapping_files.count > 0
          mapping_file = mapping_files.first
          puts "    Using mapping in #{mapping_file}" if options[:verbose]
          if File.exist?(mapping_file)
            require mapping_file
            mapper = Object.const_get("#{table_name.camelcase}Mapper")
          end
        end  
        mapper ||= Pipeline::IdentityMapping
        puts "    Using mapper: #{mapper}" if options[:verbose]
        
        FasterCSV.foreach(path, {:headers => :first_row, :col_sep => options[:delimiter]}) do |row|
          fields = mapper.map(row.headers, row, options)
          puts "    #{model}.new(#{fields})" if options[:verbose]
          
          if not options[:dry_run]
            item = model.new(fields)
            if not item.save!
              puts "Error saving model for row: #{row}"
            end
          end
        end
      end
    end
  end
  
  class AbstractMapper
    attr_reader :mappings
  end
  
  class TransformMapper < AbstractMapper
    @@pre_processing = nil
    @@post_processing = nil
     
    def self.define_mappings(mappings={})
      @@mappings = {}
      mappings.each do |from, mpg|
        to = mpg[:to]
        options = mpg.clone
        options.delete_if{|k,v| k == :to }
        @@mappings[from] = Mapping.new(to, options)
      end
    end
    
    def self.post_process(&block)
      @@post_processing = block
    end

    def self.pre_process(&block)
      @@pre_processing = block
    end
    
    def self.map(fields, data, options={})
      puts "      Mapping data from #{'['+data.fields.join(', ')+']'} ..." if options[:verbose]
      
      if @@pre_processing
        @@pre_processing.call(data)
      end
      
      mpgs = @@mappings.collect do |f, mapping| 
        mapping.apply(data[f], data, options)
      end
      
      # puts "      ... using #{'['+mpgs.join(', ')+']'} ..."
      
      mpgs_keys = mpgs.collect{ |m| m.keys }.flatten
      mpgs_vals = mpgs.collect{ |m| m.values }.flatten
      
      # puts "      ... as #{'['+mpgs_vals.join(', ')+']'} ..."
      
      attribs = mpgs_keys.zip(mpgs_vals).flatten
      attrib_hash = Hash[*attribs]
      attrib_hash = attrib_hash.delete_if{ |k,v| v.nil? }
      
      if @@post_processing
        @@post_processing.call(attrib_hash)
      end
      
      if options[:verbose]
        msg = '{'+attrib_hash.collect{|k,v| "#{k} => #{v}"}.join(', ')+'}'
        puts "      ... to #{msg}"
      end
      attrib_hash
    end
    
    def mappings
      @@transformations
    end
  end
  
  class IdentityMapper < AbstractMapper
    def self.map(fields, data)
      model_attribs = {}
      fields.each do |f|
        model_attribs[f.to_sym] = data[f]
      end
      model_attribs
    end
  end
  
  class Mapping
    attr_reader :destination, :transformation
    
    def initialize(to, options={})
      @destination = to
      @transformation = options[:transform] || lambda{ |input, context| input }
    end
    
    def apply(input, context, options={})
      result = self.transformation.call(input, context)
      puts "        #{input} ==> #{result}" if options[:verbose]
      output = { self.destination => result }   # each should return :attribute => "some value"
      output
    end
  end
end
