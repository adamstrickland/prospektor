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
    
    def self.import_delimited(options={})
      options[:input_dir] ||= @@default_import_dir
      options[:mapping_dir] ||= @@default_import_dir
      options[:delimiter] ||= "\t"
      options[:suffix] ||= ".txt"
      options[:glob] ||= "*#{options[:suffix]}"
      options[:validate] ||= false
      
      puts "Importing data from #{options[:input_dir]}" if options[:verbose]
      
      input_files = Dir.glob(File.join(options[:input_dir], options[:glob]))
      puts "Input files: #{'['+input_files.join(', ')+']'}" if options[:verbose]
      input_files.each do |path|
        puts "  Loading file #{path}" if options[:verbose]
        
        table_name = File.basename(path, options[:suffix])
        model_name = table_name.singularize.camelcase
        
        begin
          model = Object.const_get("#{model_name}")
        rescue
          eval("class #{model_name} < ActiveRecord::Base; end")
          model = Object.const_get("#{model_name}")
        end
        puts "    Loading file to table #{table_name} with model #{model}" if options[:verbose]
        
        mapping_files = Dir.glob(File.join(options[:mapping_dir], "#{table_name}_mapper.rb"))
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
        
        mapper.setup
        FasterCSV.foreach(path, {:headers => :first_row, :col_sep => options[:delimiter]}) do |row|
          begin
            fields = mapper.map(row.headers, row, options)
            puts "    #{model}.new(#{fields})" if options[:verbose]
          
            if not options[:dry_run]
              item = model.new(fields)
              if not item.save_with_validation(options[:validate])
                puts "Error saving model for row: #{row}"
              else
                mapper.aftermath(row.headers, row, item)
              end
            end
          rescue FasterCSV::MalformedCSVError
            puts row
          end
        end
        mapper.teardown
      end
    end
  end
  
  class AbstractMapper
    attr_reader :mappings
  end
  
  class TransformMapper < AbstractMapper
    @@before_all_callback = nil
    @@before_each_callback = nil
    @@before_save_callback = nil
    @@after_save_callback = nil
    @@after_all_callback = nil
    
    def self.before_all(&block); @@before_all_callback = block; end
    def self.before_each(&block); @@before_each_callback = block; end
    def self.before_save(&block); @@before_save_callback = block; end
    def self.after_save(&block); @@after_save_callback = block; end
    def self.after_all(&block); @@after_all_callback = block; end
     
    def self.define_mappings(mappings={})
      @@mappings = {}
      mappings.each do |from, mpg|
        to = mpg[:to]
        options = mpg.clone
        options.delete_if{|k,v| k == :to }
        @@mappings[from] = Mapping.new(to, options)
      end
    end
    
    # def self.post_process(&block)
    #   @@post_processing = block
    # end
    # 
    # def self.pre_process(&block)
    #   @@pre_processing = block
    # end
    
    def self.setup
      @@before_all_callback.call if @@before_all_callback
    end
    
    def self.aftermath(fields, data, model)
      @@after_save_callback.call(fields, data, model) if @@after_save_callback
    end
    
    def self.teardown
      @@after_all_callback.call if @@after_all_callback
    end
    
    def self.map(fields, data, options={})
      puts "      Mapping data from #{'['+data.fields.join(', ')+']'} ..." if options[:verbose]
      
      @@before_each_callback.call(fields, data) if @@before_each_callback
      
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
      
      @@before_save_callback.call(fields, data, attrib_hash) if @@before_save_callback
      
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
    attr_reader :destinations, :transformation
    
    def initialize(to, options={})
      @destinations = to.is_a?(Array) ? to : [to]
      @transformation = options[:transform] ||= lambda{ |input, context| input }
    end
    
    def apply(input, context, options={})
      result = self.transformation.call(input, context)
      puts "        #{input} ==> #{result}" if options[:verbose]
      output = Hash[*self.destinations.zip((0..self.destinations.count).map{ result }).flatten]
      # output = { self.destination => result }   # each should return :attribute => "some value"
      output
    end
  end
end
