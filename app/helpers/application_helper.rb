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
  
  def modal_settings(options={})
    {
      :html => { :method => :post },
      :complete => 'tb_remove()',
      # :success => "$('#history').updateHistoryFromModal(request)",
      # :failure => "$('#errors').showErrorsFromModal(request)"
    }.merge(options)
  end
  
  def update_history(lead)
    remote_function(:url => lead_events_url(lead || params[:lead_id] || @lead), :method => :get, :update => 'events')
  end
  
  def options_for_modal_with_history(options)
    options[:success] = "#{update_history(options[:lead])}; #{options[:success]}"
    options
  end
  
  def modal_form_for_with_history(model, url, options={}, &block)
    modal_form_for(model, url, options_for_modal_with_history(options), &block)
  end
  
  def modal_form_with_history(url, options={}, &block)
    modal_form(url, options_for_modal_with_history(options), &block)
  end
  
  def modal_form_for(model, url, options={}, &block)
    settings = modal_settings({ :url => url || url_for(model)}).merge(options)
    
    form_remote_for(model.class.to_s.underscore.to_sym, model, settings) do |f|
      yield(f)
    end
  end
  
  def modal_form(url, options={}, &block)
    form_remote_tag(modal_settings({ :url => url }).merge(options)) do |f|
      yield(f)
    end
  end
  
  def block_to_partial(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :locals => options))
  end
  
  def block_to_partial_string(partial_name, options = {}, &block)
    options.merge!(:body => capture(&block))
    render(:partial => partial_name, :locals => options)
  end
  
  def link_to_button(*args, &block)
    if block_given?
      options = args.first || {}
      html_options = args.second || {}
    else
      name = args.first
      options = args.second || {}
      html_options = args.third || {}
    end
    html_options[:onclick] = 'this.blur();'
    html_options[:class] = html_options[:class] ? "#{html_options[:class]} button" : "button"
    
    if block_given?
      link_to options, html_options, &block
    else
      link_to '<span>'+name+'</span>', options, html_options
    end
  end
  
  def next_lead_in_queue_url(current_lead, user=current_user)
    cq = user.call_queues.last
    next_entry = cq.touchpoints.detect{|tp| tp.lead == current_lead}.next
    if next_entry.nil?
      more_leads = user.ready_leads
      if more_leads.blank?
        empty_user_call_queue_url(user, cq)
      else
        next_lead = more_leads.first
        cq.leads << more_leads
        next_entry = cq.touchpoints.detect{|tp| tp.lead == next_lead}
        cq.save
        user_call_queue_touchpoint_url(user, cq, next_entry)
      end
    else
      user_call_queue_touchpoint_url(user, cq, next_entry)
    end
  end
end
