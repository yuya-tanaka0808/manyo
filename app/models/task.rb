class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :serch_title, ->(params) { where("title LIKE ?", "%#{params}%") }
  scope :serch_status, ->(params) { where(status: params)}
  enum priority: { 高: 0, 中: 1, 低: 2 }
end
