class Category < ActiveRecord::Base
  has_many :extensions
  acts_as_tree
  
  def Category.all_without_root
    Category.find(:all, :conditions => ["name != :vars", {:vars => "root"} ])
  end
  
  def descendants
    result = [] 
    children = self.children
    
    children.each do |child|
      result << child      
      result.concat(child.descendants)
    end
    result
  end
  
end
