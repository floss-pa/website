class Member < ApplicationRecord
  belongs_to :community
  belongs_to :user
end
