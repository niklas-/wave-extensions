module CategoriesHelper
  
  def put_category_tree(root) 
    output = ""
    for child in root.children
      output = output + content_tag(:li, (link_to child.name, category_path(child)) + content_tag(:ul, put_category_tree(child)))
      output = output.sub("<ul></ul>","")
    end
    output
  end
  
  def put_category_link(category) 
    
    unless category.name.to_s.eql?("root")
      output = link_to category.name, category_path(category)
      output = put_category_link(category.parent) + " > " + output
    else
      output = link_to "all", category_path(category)
    end
    output
  end
  
end
