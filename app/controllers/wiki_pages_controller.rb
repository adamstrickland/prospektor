class WikiPagesController < ApplicationController
  acts_as_wiki_pages_controller
  
  def history_allowed?
    current_user.has_role?('editor') || current_user.is_admin?
  end
  
  def edit_allowed?
    self.history_allowed? || current_user.has_role?('contributor')
  end  
end