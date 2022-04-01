class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    validates :username, :email, presence: true, uniqueness: true
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i ,message: ' Entered is invalid'}
    validates :password, length: {in: 6..8}
    scope :get_by_user_name,->(username){where(username: username).take!}
end
