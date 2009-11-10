# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
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
end
