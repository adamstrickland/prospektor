require 'active_record/fixtures'

def all_imports
  [:users, :events, :leads]
end

def import_all(options={})
  do_import(all_imports, options)
end

def import_one(file, options={})
  do_import([file], options)
end

def do_import(files, options={})
  settings = {
    :verbose => true,
    :delimiter => ',',
    :suffix => '.csv',
    :dry_run => true,
    :mapping_dir => File.join(Rails.root, 'db', 'import'),
    :input_dir => File.join(Rails.root, '..', 'data')
  }.merge(options)
  
  files.each do |f|
    puts "Importing #{f}..."
    Pipeline::Importer.import_delimited(settings.merge({ :glob => "#{f.to_s}#{settings[:suffix]}" }))
    puts "... done!"
  end
end

namespace :prospektor do
  namespace :import do
    namespace :dryrun do
      task :all do
        import_all
      end
      task :single, :file do |task, args|
        import_one(args.file)
      end
    end
    
    task :all do
      import_all({:verbose => false, :dry_run => false})
    end
    
    task :single, :file do |task, args|
      import_one(args.file, {:verbose => false, :dry_run => false})
    end
  end
end