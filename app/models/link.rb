class Link < ActiveRecord::Base
  validates :orig, :presence => true
  validates :comp, :presence => true, :uniqueness  => true
end
