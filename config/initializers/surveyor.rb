Surveyor::Config.run do |config|
  config['default.relative_url_root'] = nil # "surveys/" # should end with '/'
  config['default.title'] = nil # "You can take these surveys:"
  config['default.layout'] = 'surveyor' # "surveyor_default"
  config['default.index'] =  nil # "/surveys" # or :index_path_method
  config['default.finish'] =  nil # "/surveys" # or :finish_path_method
  config['use_restful_authentication'] = false # set to true to use restful authentication
  config['extend_controller'] = true # set to true to extend SurveyorController
end

# require 'models/survey_extensions' # Extended the survey model
require 'models/response_set_extensions' # Extended the ResponseSet model
# require 'helpers/surveyor_helper_extensions' # Extend the surveyor helper