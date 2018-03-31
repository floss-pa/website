class Carousel < ApplicationRecord
  belongs_to :user
  belongs_to :page
  has_paper_trail
  has_attached_file :image, styles: { carousel: "1200x500", medium: "300x300>", thumb: "100x100>" },
    :processors => [:cropper],
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  attr_accessor :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy
  after_update :reprocess_image, :if => :cropping?
  after_create :reprocess_image, :if => :cropping?

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
