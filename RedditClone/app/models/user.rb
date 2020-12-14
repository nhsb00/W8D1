class User < ApplicationRecord
    validates :username, :password_digest, :session_token, presence: true
    validates :username, :session_token, uniqueness: true
    validates :password length:{minimum: 6}, allow_nil: true 

    after_initialize :ensure_session_token
    attr_reader :password

    has_many :subs,
    foreign_key: :moderator_id,
    primary_key: :id,
    class_name: :Sub


    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return user if user && user.is_passsword?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_passsword?(password)
    end

    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token)
        self.session_token
    end

    private

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

    def self.generate_session_token
        SecureRandom.urlsafe_base64
    end

end
