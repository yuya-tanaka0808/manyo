class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, dependent: :destroy
  before_destroy :check_can_destroy_admin
  before_update :check_can_change_admin

  def check_can_destroy_admin
    if self.admin && User.where(admin: true).count == 1
      errors.add :base, '管理者が一人以上必要なため、削除できません'
      throw(:abort)
    end
  end

  def check_can_change_admin
    # if User.where(admin: true).count == 1 && self.admin_change == [true, false]
    #   errors.add :base, '管理者が一人以上必要なため、権限の変更はできません'
      throw :abort if User.where(admin: true).count == 1 && admin == false
    # end
  end

end
