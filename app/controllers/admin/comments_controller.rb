class Admin::CommentsController < ApplicationController
  
  layout 'admin'
  before_filter :require_admin
  
  # GET /admin_comments
  # GET /admin_comments.xml
  def index
    @comments = Comment.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end
  
  # GET /admin_comments/1
  # GET /admin_comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  # GET /admin_comments/new
  # GET /admin_comments/new.xml
  def new
    @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  # GET /admin_comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end
  
  # POST /admin_comments
  # POST /admin_comments.xml
  def create
    @comment = Comment.new(params[:comment])
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to([:admin, @comment]) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /admin_comments/1
  # PUT /admin_comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to([:admin,@comment]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /admin_comments/1
  # DELETE /admin_comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to(admin_comments_url) }
      format.xml  { head :ok }
    end
  end
end
