class Comment < ActiveRecord::Base
  belongs_to :sighting
  #put validations for body comments here
end
