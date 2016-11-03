class Sighting < ActiveRecord::Base  #access the methods
   belongs_to :user
   belongs_to :country
   has_many :comments
  #  mount_uploader :image, MyUploader
end
