class User < ActiveRecord::Base
    has_many :sightings
    has_many :comments
    has_secure_password #feature/method built in to AR
    # validates :password, confirmation: true
    # validates :password_confirmation, presence: true
    mount_uploader :profilepic, MyUploader
end
