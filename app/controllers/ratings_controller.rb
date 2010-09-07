class RatingsController < ApplicationController
  def add
    
    @extension_id = params[:id]
    @extension = Extension.find(@extension_id)
    
    unless session[:rated].include? @extension.id.to_s
      @rating = Rating.new
      @rating.value = params[:rating]
      @rating.ip = request.remote_ip
      @extension.ratings << @rating
      if @rating.save
        flash[:notice] = 'Thank you for rating!'
      end 
    else  
      flash[:error] = 'You´ve already rated this extension!'
    end
    
    session[:rated] << '+' <<  params[:id]
    
    #redirect_to :controller=>"extensions", :action=>"show", :id => @extension.id, :show => params[:show]
    redirect_to :back
  end
end
