class Admin::ExtensionsController < ApplicationController
  
  layout 'admin'
  before_filter :require_admin
  
  # GET /admin_extensions
  # GET /admin_extensions.xml
  def index
    @extensions = Extension.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @extensions }
    end
  end
  
  # GET /admin_extensions/1
  # GET /admin_extensions/1.xml
  def show
    @extension = Extension.find(params[:id])
    @taggings = @extension.taggings
    
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @extension }
      end
    end
    
    # GET /admin_extensions/new
    # GET /admin_extensions/new.xml
    def new
      @extension = Extension.new
      
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @extension }
      end
    end
    
    # GET /admin_extensions/1/edit
    def edit
      @extension = Extension.find(params[:id])
    end
    
    # POST /admin_extensions
    # POST /admin_extensions.xml
    def create
      @extension = Extension.new(params[:extension])
      
      respond_to do |format|
        if @extension.save
          flash[:notice] = 'Extension was successfully created.'
          format.html { redirect_to([:admin, @extension]) }
          format.xml  { render :xml => @extension, :status => :created, :location => @extension }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @extension.errors, :status => :unprocessable_entity }
        end
      end
    end
    
    # PUT /admin_extensions/1
    # PUT /admin_extensions/1.xml
    def update
      @extension = Extension.find(params[:id])
      
      respond_to do |format|
        if @extension.update_attributes(params[:extension])
          flash[:notice] = 'Extension was successfully updated.'
          format.html { redirect_to([:admin, @extension]) }
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
        format.html { redirect_to(admin_extensions_url) }
        format.xml  { head :ok }
      end
    end
  end
