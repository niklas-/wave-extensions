class TagsController < ApplicationController
  
  # GET /extensions
  # GET /extensions.xml
  def index
    @tags = Tag.find(:all)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # GET /extensions/1
  # GET /extensions/1.xml
  def show
    
    @tag = params[:id]
    redirect_to show_by_tag_path(@tag)
    
  end
  
  def list_tags
    
    @tags = Tag.find(:all)
    
    respond_to do |format|
      format.js do
        render :partial => 'tags/list'
      end
    end
  end

   
end
