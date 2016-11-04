class Comment < ActiveRecord::Base
  belongs_to :sighting
  belongs_to :user  #need this to connect comments to usernames etc
  #put validations for body comments here
end
