require 'fastercsv'
require 'active_support'
require File.join(File.dirname(__FILE__), '..', 'lib', 'pipeline')

namespace :pipeline do
  namespace :import do
    namespace :delimited do 
      task :tab, :dir do |task, args|
        options = { 
          # :verbose => true,
          # :dry_run => true,
          :delimiter => "\t",
          :input_dir => args.dir || File.join(Rails.root, "db", "import"),
          :mapping_dir => args.dir || File.join(Rails.root, "db", "import")
        }
        Pipeline::Importer.import_delimited(options)
      end
      
      task :comma, :dir, :glob do |task, args|
        options = { 
          # :verbose => true,
          # :dry_run => true,
          :delimiter => ",",
          :suffix => ".csv",
          :glob => args.glob || "*.csv",
          :input_dir => args.dir || File.join(Rails.root, "db", "import"),
          :mapping_dir => args.dir || File.join(Rails.root, "db", "import")
        }
        Pipeline::Importer.import_delimited(options)
      end
    end
    
    namespace :fixed_width do
    end
  end
end