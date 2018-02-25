class NewsContent < ApplicationRecord
  belongs_to :news, inverse_of: :news_content
  include Bootsy::Container
  has_paper_trail
  validates :news, presence: true
  validates :content, presence: true, allow_nil: false
end
