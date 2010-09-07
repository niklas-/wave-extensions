class Extension < ActiveRecord::Base
  
  acts_as_taggable
  
  belongs_to :user
  belongs_to :category
  has_many :comments, :order => "created_at DESC", :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  
  validates_presence_of :name, :description 
  validates_format_of :url, :developerurl, :allow_blank => true, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  validates_format_of :robotmail, :allow_blank => true, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  
  #validates_attachment_content_type :preview, :content_type => 'image/gif'
  
  has_attached_file :preview, :styles => { :medium => "250x200>", :thumb => "100x100>" }
  
  
  def self.per_page
    10
  end
  
  def modify_urls
    
    #empty url is allowed
    unless self.url.strip.empty?
      if not self.url.include?("http") :
        self.url = "http://" + self.url.strip
      end
    end
    
    #empty url is allowed
    unless self.developerurl.strip.empty?:
      if not self.developerurl.include?("http") :
        self.developerurl = "http://" + self.developerurl.strip
      end
    end
  end
  
  def Extension.topten(category_id)
    
    category = Category.find(category_id)
    descendants = category.descendants
    
    category_ids = []
    category_ids << category_id
    category_ids += descendants.collect(&:id)
    
    ratings = Rating.sum("value",  :joins => :extension, :conditions => { :extensions => { :category_id => category_ids  }}, :group => "extension_id", :order => "sum_value DESC", :limit => "10")
    extensions =  Array.new
    extensions = ratings.collect{ |x| Extension.find(x[0])}
    extensions
  end
end
