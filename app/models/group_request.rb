class GroupRequest < ApplicationRecord
  belongs_to :customer
  belongs_to :group

  enum is_status: { pending: 0, approved: 1, rejected: 2 }

  validates :is_status, presence: true
end
