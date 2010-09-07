class User < ActiveRecord::Base
  acts_as_authentic
  has_one :extension
  has_and_belongs_to_many :roles
  
  attr_protected :roles

end
