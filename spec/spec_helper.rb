require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  
  require 'spec/autorun'
  require 'spec/rails'
  require 'remarkable_rails'
  require 'machinist/active_record'
  require 'faker'
  require 'sham'
  require 'nokogiri'
  require 'active_record/fixtures'
  require 'chronic'
  # require 'webrat/integrations/rspec-rails'
  
  # module ActionMailerSpecSettings
  #   def self.included(base)
  #     base.send(:default_url_options=, { :host => "localhost.test" })
  #   end
  # end
  
  module ObserverTestHelperMethods
    def observer_instances
      ActiveRecord::Base.observers.collect do |observer|
        observer_klass = \
          if observer.respond_to?(:to_sym)
            observer.to_s.camelize.constantize
          elsif observer.respond_to?(:instance)
            observer
          end
        observer_klass.instance
      end
    end

    def observed_classes(observer=nil)
      observed = Set.new
      (observer.nil? ? observer_instances : [observer]).each do |observer|
        observed += (observer.send(:observed_classes) + observer.send(:observed_subclasses))
      end
      observed
    end

    def observed_classes_and_their_observers
      observers_by_observed_class = {}
      observer_instances.each do |observer|
        observed_classes(observer).each do |observed_class|
          observers_by_observed_class[observed_class] ||= Set.new
          observers_by_observed_class[observed_class] << observer
        end
      end
      observers_by_observed_class
    end

    def disable_observers(options={})
      except = options[:except]
      observed_classes_and_their_observers.each do |observed_class, observers|
        observers.each do |observer|
          unless observer.class == except
            observed_class.delete_observer(observer)
          end
        end
      end
    end

    def enable_observers(options={})
      except = options[:except]
      observer_instances.each do |observer|
        unless observer.class == except
          observed_classes(observer).each do |observed_class|
            observer.send :add_observer!, observed_class
          end
        end
      end
    end
  end
  
  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each{ |f| require f }
  
  Spec::Matchers.define :be_json_like do |hash|
    match do |response|
      ActiveSupport::JSON.decode(response.body) == ActiveSupport::JSON.decode(hash.to_json)
    end

    failure_message_for_should do |actual|
      "expected #{ActiveSupport::JSON.decode(expected)} but received #{ActiveSupport::JSON.decode(actual.body)}"
    end

    failure_message_for_should_not do |actual|
      "expected something other than #{ActiveSupport::JSON.decode(expected)} but received #{ActiveSupport::JSON.decode(actual.body)}"
    end

    description do
      "be a JSON object like #{ActiveSupport::JSON.decode(expected)}"
    end
  end
  
  Spec::Runner.configure do |config|
    def mock_user(role=:any, options={})
      user = mock_model(User)
      
      options[:id] ||= 42
      
      [:find, :find_by_id].each do |m|
        User.stub!(m).with(options[:id]).and_return(user)
        User.stub!(m).with(options[:id].to_s).and_return(user)
      end
      user.stub!(:save).and_return(true)
      user.stub!(:id).and_return(options[:id])
      user.stub!(:destroyed?).and_return(false)
      
      emp = mock_model(Employee)
      user.stub!(:has_attribute?).with('employee_id').and_return(true)
      user.stub!(:employee).and_return(emp)
      emp.stub!(:preferred_name).and_return('Seamus')
      emp.stub!(:first_name).and_return('Seamus')
      emp.stub!(:last_name).and_return('McGregor')
      
      user.stub!(:is_admin?).and_return(role == :admin)
      
      user_role = mock_model(Role)
      user_role.stub!(:title).and_return(role.to_s.downcase)
      user.stub!(:roles).and_return([user_role])
      [:admin, :manager, :sales].each do |r|
        user.stub!(:has_role?).with(r).and_return(role == r ? true : false)
      end
      user
    end
    
    def login_as(role)
      login_using(mock_user(role))
    end
    
    def login_using(user)
      @current_user = user
      request.session[:user] = @current_user
      if defined?(controller)
        controller.send :current_user=, @current_user
      else
        template.stub!(:logged_in?).and_return(true)
        template.stub!(:current_user).and_return(@current_user)
      end
      @current_user
    end
    
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
    config.global_fixtures = :states, :time_zones, :statuses, :topics, :sic_codes, :roles
    
    config.before(:all) do
      Sham.reset(:before_all)
      
      #load survey stuff
      survey_fixture_dir = File.expand_path(File.join(Rails.root, 'surveys', 'fixtures'))
      Fixtures.create_fixtures(survey_fixture_dir, Dir[File.join(survey_fixture_dir, "*.yml")].map{ |f| File.basename(f, ".yml").to_sym })
      
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
    end
    
    config.before(:each) do
    end
    
    config.after do
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'spec/blueprints'

  Sham.reset(:before_each)
end

# --- Instructions ---
# - Sort through your spec_helper file. Place as much environment loading 
#   code that you don't normally modify during development in the 
#   Spork.prefork block.
# - Place the rest under Spork.each_run block
# - Any code that is left outside of the blocks will be ran during preforking
#   and during each_run!
# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.
#




# # This file is copied to ~/spec when you run 'ruby script/generate rspec'
# # from the project root directory.
# ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
# require 'spec/autorun'
# require 'spec/rails'
# 
# require File.expand_path(File.join(File.dirname(__FILE__), 'blueprints'))
# 
# # Uncomment the next line to use webrat's matchers
# #require 'webrat/integrations/rspec-rails'
# 
# # Requires supporting files with custom matchers and macros, etc,
# # in ./support/ and its subdirectories.
# Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
# 
# Spec::Runner.configure do |config|
#   # If you're not using ActiveRecord you should remove these
#   # lines, delete config/database.yml and disable :active_record
#   # in your config/boot.rb
#   # config.use_transactional_fixtures = true
#   # config.use_instantiated_fixtures  = false
#   # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
#   
#   config.before(:all)  { Sham.reset(:before_all) }
#   config.before(:each) { Sham.reset(:before_each) }
# 
#   # == Fixtures
#   #
#   # You can declare fixtures for each example_group like this:
#   #   describe "...." do
#   #     fixtures :table_a, :table_b
#   #
#   # Alternatively, if you prefer to declare them only once, you can
#   # do so right here. Just uncomment the next line and replace the fixture
#   # names with your fixtures.
#   #
#   # config.global_fixtures = :table_a, :table_b
#   #
#   # If you declare global fixtures, be aware that they will be declared
#   # for all of your examples, even those that don't use them.
#   #
#   # You can also declare which fixtures to use (for example fixtures for test/fixtures):
#   #
#   # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
#   #
#   # == Mock Framework
#   #
#   # RSpec uses it's own mocking framework by default. If you prefer to
#   # use mocha, flexmock or RR, uncomment the appropriate line:
#   #
#   # config.mock_with :mocha
#   # config.mock_with :flexmock
#   # config.mock_with :rr
#   #
#   # == Notes
#   #
#   # For more information take a look at Spec::Runner::Configuration and Spec::Runner
#   def app
#     @_app ||= ActionController::Integration::Session.new
#   end
#   
#   def flash
#     @_flash ||= app.flash
#   end
# 
#   def login_as(user)
#     @current_user = mock_model(User)
#     User.stub!(:find_by_id).and_return(@current_user)
#     @current_user.stub!(:save).and_return(true)
#     controller.stub!(:current_user).and_return(@current_user)
#     case user
#       when :admin
#         User.stub!(:is_admin?).and_return(true)
#     end    
#     request.session[:user] = @current_user
#   end
#   # 
#   # def current_user
#   #   @current_user ||= mock_model(User)
#   # end
#     
# end
