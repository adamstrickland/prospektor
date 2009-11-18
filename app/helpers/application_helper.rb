# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # def self.included(base)
  #   base.class_eval do
  #     alias_method :orig_image_tag, :image_tag
  #     alias_method :image_tag, :new_image_tag
  #   end
  # end
  
  def javascript_action_include_tag
    # js_file_path = File.join(File.dirname(__FILE__), "..", "..", "public", "javascripts", controller_name, "#{action_name}.js")
    # # puts "JS File.exists?: #{js_file_path}"
    # if File.exists?(js_file_path)
    #   javascript_include_tag File.join(controller_name, action_name)
    # end
    asset_in_public('javascripts') do |f|
      javascript_include_tag f
    end
  end
  
  def stylesheet_action_link_tag
    # js_file_path = File.join(File.dirname(__FILE__), "..", "..", "public", "javascripts", controller_name, "#{action_name}.js")
    # # puts "JS File.exists?: #{js_file_path}"
    # if File.exists?(js_file_path)
    #   javascript_include_tag File.join(controller_name, action_name)
    # end
    asset_in_public('stylesheets') do |f|
      stylesheet_link_tag f
    end
  end
  
  def asset_in_public(subdir, &block)
    public_path = File.join(File.dirname(__FILE__), '..', '..', 'public')
    file_glob = File.join(public_path, subdir, controller_name, "#{action_name}.*")
    if Dir.glob(file_glob).map{|f| File.exists?(f)}.delete_if{|b| !b}.count > 0
      yield(File.join(controller_name, action_name))
    end
  end
  
  def onclick_to_remote(options = {})
    "onclick=\"#{link_for_event(options)}; return false;\""
    # *args = remote_function(options)
    # function = args[0] || ''
    # function = update_page(&block) if block_given?
    # "onclick=\"#{function}; return false;\""
  end
  
  def link_for_event(options={})
    *args = remote_function(options)
    function = args[0] || ''
    function = update_page(&block) if block_given?
    "#{function}; return false;"
  end
    
  def widget_item(field_name)
    render :partial => 'common/widget_item', :locals => { :field_name => field_name }
  end
  
  def image_url(image_name)
    img_url = path_to_image(image_name)
    unless img_url =~ /\Ahttp/ 
      img_url = "http#{'s' if https?}://#{host_with_port}/#{rel_path}" 
    end 
    img_url
  end
  
  def absolute_image_tag(source, options={})
    # new_source = options[:absolute] ? image_url(source) : source
    image_tag(image_url(source), options)
  end
  # 
  # def pdf_path(asset_name, options={})
  #   url_for(:controller => 'help', :action => 'pdf', :asset => 'asset_name')
  # end
end
