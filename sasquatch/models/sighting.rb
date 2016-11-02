class Sighting < ActiveRecord::Base  #access the methods
   belongs_to :user
   has_many :comments
  #  mount_uploader :image, MyUploader
end
