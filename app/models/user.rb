class User < ApplicationRecord
    validates :session_token, uniqueness: true
    validates :email, uniqueness: true
    after_initialize :ensure_session_token

   def self.find_by_credentials(email, password)
        user = User.find(email: email)
        if user && user.is_password?(password)
            user
        else
            nil
        end
   end

   def is_password?(password)
        password_object = BCrypt::Password.new(password)
        password_object.is_password?(password)
   end

   def password
        @password
   end

   def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
   end

   def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
   end

   def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
   end

end