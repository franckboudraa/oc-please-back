class Message < ApplicationRecord
  belongs_to :user
  belongs_to :volunteer
  validates :content, length: {in: 2...255}
  validates :user_id, :content, :volunteer_id, presence: true
end
