class CommentsController < ApplicationController
  # GET /extensions
  # GET /extensions.xml
#  def index
#    @extension = Extension.find(params[:id])
#    @comments = Comment.find(:all, :conditions => {:extension_id => @extension.id})
#    
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @comments }
#    end
#  end
  
  # GET /extensions/new
  # GET /extensions/new.xml
  def new
    @extension = Extension.find(params[:id])
    @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # POST /extensions
  # POST /extensions.xml
  def create
    @comment = Comment.new
    @comment.subject = params[:post][:subject]
    @comment.message = params[:post][:message]
    @comment.nickname = params[:post][:nickname]
    @extension = Extension.find(params[:extension_id])
    @comment.extension_id = @extension.id
    @comments = @extension.comments
    
    @source = params[:source]
    
    if @comment.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'The comment was successfully created!'
          if @source.to_s.include? 'index'
            redirect_to :controller=>"extensions", :action=>"index", :id => @extension.id, :show => true
          else
            redirect_to :controller=>"extensions", :action=>"show", :id => @extension.id, :show => true
          end
        end
        format.js
      end
    else
      flash[:error] = 'Please enter text before submitting!'
      redirect_to :back
    end
  end
end
