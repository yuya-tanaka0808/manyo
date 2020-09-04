class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :serch_title, ->(params) { where("title LIKE ?", "%#{params}%") }
  scope :serch_status, ->(params) { where(status: params)}

end
