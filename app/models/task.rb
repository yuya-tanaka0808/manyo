class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :serch_title, ->(params) { where("title LIKE ?", "%#{params}%") }
end
