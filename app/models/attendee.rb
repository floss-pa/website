class Attendee < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_one :event, through: :ticket
  validates :ticket, uniqueness: { scope: :user}
  after_create :send_ticket

  def send_ticket
    unless self.user.email.include?('facebook')
      cal=self.event.create_calendar_entry
      TicketMailer.new_ticket(self.id,cal).deliver
    end
  end
end
