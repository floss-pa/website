class Attendee < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_one :event, through: :ticket
  validates :ticket, uniqueness: { scope: :user}
end
