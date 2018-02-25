class News < ApplicationRecord
  belongs_to :user
  has_one :news_content,inverse_of: :news
  validates :user, presence: true
  validates :title, presence: true, length: {minimum: 6, maximum: 255}, allow_nil: false
  accepts_nested_attributes_for :news_content
  before_save :set_published_date
  has_paper_trail

  def set_published_date
    if self.publish
      self.published_at=Date.today
    end
  end
end
