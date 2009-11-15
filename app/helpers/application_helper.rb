# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # def self.included(base)
  #   base.class_eval do
  #     alias_method :orig_image_tag, :image_tag
  #     alias_method :image_tag, :new_image_tag
  #   end
  # end
  
  def javascript_action_tag
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
end
