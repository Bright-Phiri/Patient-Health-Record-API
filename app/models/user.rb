class User < ApplicationRecord
    has_secure_password
    validates :username, :email, :password, presence: true, uniqueness: true
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,message: ' Entered is invalid'}
    validates :password, length: {is: 8}
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    scope :get_by_user_name,->(username){where(username: username).take!}
end
