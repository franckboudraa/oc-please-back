class Volunteer < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum status: [:pending, :accepted]
end
