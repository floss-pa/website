class Community < ApplicationRecord
  belongs_to :user
  has_many :members
  validates :user, presence: :true
  validates :name, presence: :true, uniqueness: true, length: {minimum: 6, maximum: 255}, allow_nil: false
  validates :information, presence: true,  length: {minimum: 10}, allow_nil: false
  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  after_create :add_first_member

  private
  def add_first_member
    member=Member.new
    member.community_id = self.id
    member.user_id = self.user_id
    member.admin = true
    member.save
  end
end
