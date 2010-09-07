module ExtensionsHelper
  
  def preview(extension)
    
    size = extension.description.to_s.size
    substring = 120
    if size < substring
      substring = size  
    end
    previewsize = extension.description.to_s[0,substring].rindex(" ")
    
    if previewsize.blank?
      previewsize = size
    end
    extension.description.to_s[0,previewsize]
  end
  
  def seconds_fraction_to_time(seconds)
    days = 0
    hours = 0
    mins = 0
    if seconds >=  60 then
      mins = (seconds / 60).to_i 
      seconds = (seconds % 60 ).to_i
      
      if mins >= 60 then
        hours = (mins / 60).to_i 
        mins = (mins % 60).to_i
        
        if hours >= 24 then
          days = (hours / 24).to_i 
          hours = (hours % 24).to_i
        end
      end
    end
    [days,hours,mins,seconds]
  end
  
  def put_time_since_posted(time)
    posttime = Time.parse(time)
    ago = Time.now - posttime
    days, hours, minutes, seconds = seconds_fraction_to_time(ago)
    
    if minutes == 1
      output = minutes.to_s + " minute ago."
    else
      output = minutes.to_s + " minutes ago."
    end
    unless hours == 0
      if hours == 1
        output = hours.to_s + " hour and " + output
      else
        output = hours.to_s + " hours and " + output
      end
    end
    unless days == 0
      if days == 1
        output =  days.to_s + " day, " + output
      else days 
        output =  days.to_s + " days, " + output
      end
    end    
    
    output
  end
  
  def decorate_with_icon(position)
    case position
      when 1 then return  (image_tag "1trophy.png")
      when 2 then return  (image_tag "2trophy.png")
      when 3 then return  (image_tag "3trophy.png")
      when 4..9 then return ("No." + position.to_s)
      when 10 then return  (image_tag "lantern.png")
    end
  end
  
  def put_preview_picture(extension, style, mousover_style)
    picture = extension.preview.url(style)
    if picture.include? "missing" 
      return "" 
    else 
      return (image_tag extension.preview.url(style), :class=>"right", :mouseover => extension.preview.url(mousover_style))
    end
  end
  
  def put_bullet
    content_tag(:span, ">>" , :class => "linkbullet")
  end
  
  
  def put_optional_details(extension)
    output = ""
    unless extension.license.blank?
      output += content_tag(:p, (put_bullet + " extension is published under the " + extension.license))      
    end
    unless extension.url.blank?
      output += content_tag(:p, (put_bullet + " download the extension " + (link_to "here", extension.url)))      
    end
    unless extension.developerurl.blank?
      output += content_tag(:p, (put_bullet + " view the developer site " + (link_to "here", extension.developerurl)))      
    end
    unless extension.robotmail.blank?
      output += content_tag(:p, (put_bullet + " robot address is " + extension.robotmail))      
    end
    output
  end
  
  
end