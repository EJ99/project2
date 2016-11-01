class User < ActiveRecord::Base
    has_secure_password #feature/method built in to AR
end
