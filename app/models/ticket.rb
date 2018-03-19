class Ticket < ApplicationRecord
  belongs_to :event #, inverse_of: :ticket
  belongs_to :ticket_type
  has_one :user, through: :event
  has_many :attendees
  after_create :add_token

  private

  def add_token
    event=self.event
    self.token=event.title.gsub(/\s/,'-') + '-' + self.event_id.to_s + '-' + self.id.to_s
    self.save
    event.ticket_url=Rails.application.routes.url_helpers.ticket_url(self.token)
    event.save
  end
end
