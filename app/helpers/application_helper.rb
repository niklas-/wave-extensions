# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def put_meta_title
    @title
  end
  
  def set_meta_title(title)
    tmptitle = title.blank? ? "" : title
    @title = "<title> #{tmptitle} - wave-extensions.net </title>"
  end
  
  def put_meta_description
    description = "wave extensions"
    if @extension && !@extension.new_record?
      description = @extension.name + " : " + @extension.description
    end
   "<meta name=\"description\" content=\"#{description}\"/>"
  end
  
  def put_meta_keywords
    keywords = "wave,extensions,robot,gadget"
    if @extension and !@extension.new_record?
      keywords += "," + [@extension.name, @extension.user.login, @extension.created_at.to_s(:month_year)].join(',' )
    end
     "<meta name=\"keywords\" content=\"#{keywords}\"/>"
  end
end
