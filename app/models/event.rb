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
    styles: { :event=>"1200x500",:ticket=> "600x250", :project=>"320x175",:medium => "200x200>" } ,
     :processors => [:cropper],
     :default_style => :event,
     default_url: ->(attachment) { ActionController::Base.helpers.asset_path("event_default.png") }
  validates_attachment_content_type :image, :content_type => /^image\/(png|jpeg|jpg)/
  accepts_nested_attributes_for :tickets
  attr_accessor :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy
  after_update :reprocess_image, :if => :cropping?
  after_create :reprocess_image, :if => :cropping?

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

  private

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    tmpfile = image.queued_for_write[style]
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(tmpfile)
  end

  def reprocess_image
    image_geometry(:original)
    self.crop_h = 500
    self.crop_w = 1200
    self.crop_y = (@geometry[:original].height.to_f * (self.crop_y.to_f / self.crop_vy.to_f)).to_i
    self.crop_x = (@geometry[:original].width.to_f * (self.crop_x.to_f / 1100.to_f)).to_i
    image.assign(image)
    image.save
  end
end
