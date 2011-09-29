class Link < ActiveRecord::Base
  validates :orig, :presence => true, :uniqueness  => true
  validates :comp, :presence => true, :uniqueness  => true
end
