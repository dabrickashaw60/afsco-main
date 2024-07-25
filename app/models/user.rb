class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { super_admin: 'super_admin', salesman: 'salesman', installer: 'installer' }
  
  validates :name, presence: true
  has_many :appointments, dependent: :destroy
  validates :role, presence: true, inclusion: { in: roles.keys }

  has_many :jobs, foreign_key: 'salesman_id'

  def admin?
    role == 'admin'
  end
  
end
