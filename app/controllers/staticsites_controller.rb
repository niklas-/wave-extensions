class StaticsitesController < ApplicationController
  
  
  def blog
    redirect_to("http://localhost:3002")
  end
  
  def impressum
    respond_to do |format|
      format.html 
      format.xml  { render :xml }
    end
  end
  
  def getDS
    send_file("public/documents/ExaVisions_Datenschutzerklaerung.pdf", :type => 'application/pdf', :disposition => 'inline')
  end
  
end
