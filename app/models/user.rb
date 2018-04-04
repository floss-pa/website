class User < ApplicationRecord
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :news
  has_many :pages
  has_many :carousels
  has_many :communities
  has_many :members
  has_many :events
  has_many :attendees
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change-me'
  TEMP_EMAIL_REGEX = /\Achange-me/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates :name,
       :presence => true #,
  #     :format => {:with=> /\A[\p{Word}\p{space}]*\z/, :message=> I18n.t(:no_special_characters) }
  has_attached_file :avatar,
           styles: { :project=>"400x400",:medium => "200x200>", :thumb => "40x40>" },
           :processors => [:cropper],
           default_url: ->(attachment) { ActionController::Base.helpers.asset_path("user_avatar.png") }
  validates_attachment_content_type :avatar, :content_type => /^image\/(png|gif|jpeg|jpg)/
  validate :domain_invalid?
  attr_accessor :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy

  after_update :reprocess_image, :if => :cropping?
  after_create :reprocess_image, :if => :cropping?

  def self.find_for_oauth(auth, signed_in_resource = nil)
    logger.info auth.inspect
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      unless email_is_verified
        if auth.provider=='facebook' and !auth.info.email.include?('facebook')
          email=auth.info.email
        else auth.provide=='github' and !auth.info.email.include?('github')
          email=auth.info.email
        end
      end
      logger.info "email: #{email}"
      user = User.where(:email => email).first if email
      if user.nil?
        res = Net::HTTP.get_response(URI(auth.info.image + "?type=large"))
        logger.info "res: #{auth.info.image}?type=large"
        user = User.new(
          name: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}@#{auth.provider}.com",
          password: Devise.friendly_token[0,20],
          avatar: open(auth.info.image + "?type=large")
        )
        user.skip_confirmation!
        user.save!
      else
        user.confirmed_at=DateTime.now.to_s(:db) if user.confirmed_at.nil?
        user.save!
      end
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  def domain_invalid?
    begin
      domain = self.email.split("@").last
      s = Socket.gethostbyname(domain)
    rescue SocketError
      errors.add(:email, :invalid_domain, not_allowed: " email domain is invalid")
      return false
    end
  end

  private

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    tmpfile = avatar.queued_for_write[style]
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(tmpfile)
  end

  def reprocess_image
    image_geometry(:original)
    self.crop_h = 400
    self.crop_w = 400
    self.crop_y = (@geometry[:original].height.to_f * (self.crop_y.to_f / self.crop_vy.to_f)).to_i
    self.crop_x = (@geometry[:original].width.to_f * (self.crop_x.to_f / 380.to_f)).to_i
    avatar.assign(avatar)
    avatar.save
  end

end
