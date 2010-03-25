class WikiPagesController < ApplicationController
  layout 'wiki'
  acts_as_wiki_pages_controller
  
  def history_allowed?
    current_user.has_role?('editor') || current_user.is_admin?
  end
  
  def edit_allowed?
    self.history_allowed? || current_user.has_role?('contributor')
  end   
    
  # Initialize @page instance variable
  def setup_page
    path = params[:path].respond_to?(:join) ? params[:path].join('/') : params[:path]
    @page = page_class.find_by_path_or_new( path ) # Find existing page by path or create new
  end 
  
  # def new
  #   @page = WikiPage.new
  # end
  # 
  # def create
  #   @page = WikiPage.new(params[:wiki_page])
  # 
  #   respond_to do |format|
  #     if @page.save
  #       flash[:notice] = 'Page was successfully created.'
  #       format.html { redirect_to(@page) }
  #     else
  #       format.html { render :action => "new" }
  #     end
  #   end    
  # end
end