module TagsHelper
  
  def put_tags(taggings) 
    
    output = ""
    size = taggings.size
    i = 0
    for tagging in taggings
      tag = tagging.tag
      output = output + (link_to tag.name, show_by_tag_path(tag.id))
      output = output + "|" unless i == size -1
      i = i + 1
    end 
    output
  end
  
end
