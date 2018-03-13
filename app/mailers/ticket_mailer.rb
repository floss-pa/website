class TicketMailer < ApplicationMailer
  default from: 'do-not-reply@floss-pa.net'

  def new_ticket(attendee,ical)
    @attendee = Attendee.find(attendee)
    @user = @attendee.user
    @event = @attendee.event
    begin
      @qr = RQRCode::QRCode.new( attendee_url(@attendee.id), :size => 5, :level => :h )
    rescue RQRCode::QRCodeRunTimeError => e
      logger.info "Manage qr error in new ticket #{e.inspect}"
    end
    mail.attachments['floss-pa-event.ics'] = { mime_type: 'application/ics', content: ical.to_ical } unless ical.nil?
    mail(to: @user.email, subject: t(:ticket_for)  + ' ' + @event.title)
  end
end
