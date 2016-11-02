class User < ActiveRecord::Base
    has_many :sightings
    has_secure_password #feature/method built in to AR
end
