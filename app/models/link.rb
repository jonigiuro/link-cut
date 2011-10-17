class Link < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :orig, :presence => true
  validates :comp, :presence => true, :uniqueness  => true
end
