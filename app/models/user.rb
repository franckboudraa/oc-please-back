class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  validates :first_name,  presence: true, length: {in: 2..30}, format: { with: /\A[a-zA-Z]+\z/ }
  validates :last_name,  presence: true, length: {in: 2..30}, format: { with: /\A[a-zA-Z]+\z/ }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end