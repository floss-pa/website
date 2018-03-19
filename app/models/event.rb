class Event < ApplicationRecord
  belongs_to :user
  #belongs_to :community
  has_many :tickets #, inverse_of: :event
  has_many :attendees, :through => :tickets
  date_time_attribute :start_at
  date_time_attribute :end_at
  validates :title, presence: true, length: { minimum: 8}
  validates :description, presence: true, length: { minimum: 10}
  validates :start_at, presence: true
  validates :end_at, presence: true
  has_attached_file :image,
           styles: { :event=>"1200x500",:ticket=> "600x180", :project=>"320x138",:medium => "200x200>", :thumb => "40x40>" } ,
           default_url: ->(attachment) { ActionController::Base.helpers.asset_path("event_default.png") }
  validates_attachment_content_type :image, :content_type => /^image\/(png|gif|jpeg|jpg)/
  accepts_nested_attributes_for :tickets

  def create_calendar_entry
    cal = Icalendar::Calendar.new
      cal.timezone do |t|
        t.tzid = "America/Panama"
      end
      cal.event do |e|
        e.dtstart = Icalendar::Values::DateTime.new(self.start_at)
        e.dtend = Icalendar::Values::DateTime.new(self.end_at)
        e.summary = self.title
        e.description = self.description
        e.ip_class = "PRIVATE"
      end
      cal
  end
end
