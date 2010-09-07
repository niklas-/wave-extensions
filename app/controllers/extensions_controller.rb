class ExtensionsController < ApplicationController
  
  before_filter :require_user, :only => :new
  #before_filter :paginate, :only => :index
  #before_filter :paginate, :only => :index
  # GET /extensions
  # GET /extensions.xml
  def index
    
    if session[:rated].nil?
      session[:rated] = ""
    end
    
    @extensions = Extension.paginate :page => params[:page], :order => 'created_at DESC'
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # GET /extensions/1
  # GET /extensions/1.xml
  def show
    
    if session[:rated].nil?
      session[:rated] = ""
    end
    
    if session[:visited].nil?
      session[:visited] = 1
    end
    
    @id = params[:id]
    @extension = Extension.find(@id)
    
    @ratings = @extension.ratings
    
    #increment view count
    @extension.update_attribute(:view_count, @extension.view_count + 1)  unless session[:visited] > 1 
    session[:visited] = session[:visited] + 1
    
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # GET /extensions/new
  # GET /extensions/new.xml
  def new
    @extension = Extension.new
    @categories = Category.find(:all)
    @category = Category.new
    @catnames = Array.new
    @categories.each do |category|
      unless category.name.eql? "root"
        @catnames << category.name
      end
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # GET /extensions/1/edit
  #  def edit
  #    @extension = Extension.find(params[:id])
  #  end
  
  # POST /extensions
  # POST /extensions.xml
  def create
    
    @extension = Extension.new(params[:extension])
    begin
      #workaround to extract category id
      category_id = params.fetch('nil_class').fetch('id')     
      @category = Category.find(category_id)
      @extension.category = @category
      
      @extension.user = current_user
      
      #check if both url attributes have the protocoll defined and 
      #add if missing. This will prevent routing issues
      @extension.modify_urls
      
      #initialize count always with 0
      @extension.view_count = 0;
      
      #initialize an extension always with a rating of 3
      rating = Rating.new
      rating.value = 3
      rating.ip = request.remote_ip
      @extension.ratings << rating
      
      if @extension.save
        flash[:notice] = 'The extension was successfully created!'
        render :action => "preview"
        #redirect_to :controller=>"extensions", :action=>"preview"
        #redirect_to :controller=>"extensions", :action=>"index"
      else
        render :action => :new
      end
      
    rescue ActiveRecord::RecordNotFound, IndexError
      flash[:error] = 'The extension could not be saved. Please check the categories select box!'
      render :action => :new
    end
  end
  
  # GET /admin_extensions/1/edit
  def edit
    @extension = Extension.find(params[:id])
  end
  
  
  # PUT /admin_extensions/1
  # PUT /admin_extensions/1.xml
  def update
    @extension = Extension.find(params[:id])
    
    respond_to do |format|
      if @extension.update_attributes(params[:extension])
        flash[:notice] = 'Extension was successfully updated.'
        format.html { redirect_to(@extension) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @extension.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin_extensions/1
  # DELETE /admin_extensions/1.xml
  def destroy
    @extension = Extension.find(params[:id])
    @extension.destroy
    
    respond_to do |format|
      format.html { redirect_to(extensions_url) }
      format.xml  { head :ok }
    end
  end
  
  def toggle_comments
    @extension = Extension.find(params[:id])
    @comments = @extension.comments
    
    respond_to do |format|
      format.js do
        #render :update do |page|
        # page.alert 'okay'
        #end
        render :partial => 'comments/index'
      end
    end
  end
  
  def show_by_tag
    
    @tagname = Tag.find(params[:id])
    @extensions = Extension.find_tagged_with(@tagname.to_s)
    @extensions = Extension.paginate @extensions, :page => params[:page], :order => 'created_at DESC'
    
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  def show_by_rating
    
    category_id = 1
    if params[:by] == "robots"
      category_id = 2
    elsif params[:by] == "gadgets"
      category_id = 3
    end
    
    @extensions = Extension.topten(category_id)
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  def show_by_category
    
    @category = Category.find(params[:id])
    @extensions = Extension.paginate_by_category_id @category, :page => params[:page], :order => 'created_at DESC'
    
    respond_to do |format|
      format.html
      format.xml 
    end
  end 
  
  def plain_list
    
    @extensions = Extension.find(:all, :order => 'name ASC')
    
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  def preview
    
    respond_to do |format|
      format.html
      format.xml 
    end
  end
  
  def rss
    
    @extensions = Extension.find(:all, :order => "id DESC")
    render  :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
end
