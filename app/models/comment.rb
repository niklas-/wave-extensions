class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :extension
  acts_as_tree :order => "subject"
  validates_presence_of :message
end
