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
          :delimiter => "\t"
        }
        Pipeline::Importer.import_delimited(args.dir || File.join(File.dirname(__FILE__), "..", "..", "..", "..", "db", "import"), options)
      end
      
      task :comma, :dir, :glob do |task, args|
        options = { 
          # :verbose => true,
          # :dry_run => true,
          :delimiter => ",",
          :suffix => ".csv",
          :glob => args.glob || "*.csv"
        }
        Pipeline::Importer.import_delimited(args.dir || File.join(File.dirname(__FILE__), "..", "..", "..", "..", "db", "import"), options)
      end
    end
    
    namespace :fixed_width do
    end
  end
end