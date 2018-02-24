class Page < ApplicationRecord
  belongs_to :user
  has_many :carousels
  include Bootsy::Container
  validates :user, presence: true
  validates :title, presence: true,  allow_nil: false
  validates :language, presence: true, allwo_nil: false
  validates :keywords, presence: true
  validates :content, presence: true, allow_nil: false
end
