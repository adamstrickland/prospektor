module DispositionHelper
  def disposition_form(lead, &block)
    modal_form_with_history(
      lead_disposition_index_url(lead, :format => :json), 
      :success => update_page{ |p| 
        p.redirect_to(user_call_manager_url(current_user))
      },
      &block 
    )
  end
end
