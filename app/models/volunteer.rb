class Volunteer < ApplicationRecord
  belongs_to :request
  belongs_to :user
  has_many :messages, dependent: :destroy

  enum status: [:pending, :accepted, :declined]
end
