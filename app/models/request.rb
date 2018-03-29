class Request < ApplicationRecord
  belongs_to :user
  has_many :volunteers
  validates :title, length: {in: 2..64}, format: { with: /\A[a-zA-Z]+\z/ }
  validates :title, :description, :lat, :lng, :address, :status, :type, :user_id, presence: true
  enum status: [:unfulfilled, :fulfilled]
  enum type: [:task, :need]
end
