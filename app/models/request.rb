class Request < ApplicationRecord
  belongs_to :user
  has_many :volunteers, dependent: :destroy
  has_many :messages, through: :volunteers
  validates :title, length: {in: 2..64}
  validates :title, :description, :lat, :lng, :address, :status, :reqtype, :user_id, presence: true
  enum status: [:unfulfilled, :fulfilled]
  enum reqtype: [:task, :need]
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
end
