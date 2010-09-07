class CategoriesController < ApplicationController
  
  # GET /extensions
  # GET /extensions.xml
  def index
    
    @root = Category.find_by_name("root")
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @extension }
    end
  end
  
  # GET /extensions/1
  # GET /extensions/1.xml
  def show
    
    @category = Category.find(params[:id])
    redirect_to show_by_category_path(@category)
  end
  
end
