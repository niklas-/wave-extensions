class Admin::TagsController < ApplicationController
  
  layout 'admin'
  before_filter :require_admin
  
  # GET /admin_tags
  # GET /admin_tags.xml
  def index
    @tags = Tag.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end
  
  # GET /admin_tags/1
  # GET /admin_tags/1.xml
  def show
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end
  
  # GET /admin_tags/new
  # GET /admin_tags/new.xml
  def new
    @tag = Tag.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end
  
  # GET /admin_tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end
  
  # POST /admin_tags
  # POST /admin_tags.xml
  def create
    @tag = Tag.new(params[:tag])
    
    respond_to do |format|
      if @tag.save
        flash[:notice] = 'Admin::Tag was successfully created.'
        format.html { redirect_to([:admin, @tag]) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin_tags/1
  # PUT /admin_tags/1.xml
  def update
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Admin::Tag was successfully updated.'
        format.html { redirect_to([:admin, @tag]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin_tags/1
  # DELETE /admin_tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_tags_url) }
      format.xml  { head :ok }
    end
  end
end
