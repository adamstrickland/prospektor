namespace :data do
  task :fixtures do
    require 'active_record/fixtures'
    data_path = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'db', 'data', RAILS_ENV))
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym) 
    Dir.glob(data_path+'/*.yml').each do |f|
      puts "Loading #{f.to_s}"
      
      #normally looks like Fixtures.create_fixtures('path/to/yml/dir', 'model_name')
      Fixtures.create_fixtures(data_path, File.basename(f, '.*'))
    end
  end
  
  task :machinist, :records do |task, args|
    machinist_dir = File.join(File.dirname(__FILE__), '..', '..', 'db', 'machinist')
    require File.expand_path(File.join(machinist_dir, 'machinist'))
    blueprint_dir = File.expand_path(File.join(machinist_dir, RAILS_ENV))
    ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
    num_records = args[:records] || 100
    
    Dir.glob(blueprint_dir+'/*.rb').each do |f|
      klass = File.basename(f, ".rb").camelize.constantize
      if klass.respond_to?('make')
        puts "Generating data for #{klass.to_s} with blueprint at #{f.to_s}"
        num_records.times do |i|
          klass.make
        end
      end
    end
  end
end
