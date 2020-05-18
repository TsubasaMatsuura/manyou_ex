class User < ApplicationRecord
	 has_many :tasks
  before_validation { email.downcase! }
  before_destroy :do_not_destroy_last_admin

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness:true,
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  
   private
    def do_not_destroy_last_admin
        throw(:abort) if User.where(admin: true).count <= 1 && self.admin?
    end
end
