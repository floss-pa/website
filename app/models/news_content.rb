class NewsContent < ApplicationRecord
  belongs_to :news, inverse_of: :news_content
  include Bootsy::Container
  validates :news, presence: true
  validates :content, presence: true, allow_nil: false
end
