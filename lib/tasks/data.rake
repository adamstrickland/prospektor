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
end
