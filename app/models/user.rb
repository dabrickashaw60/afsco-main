class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { super_admin: 'super_admin', salesman: 'salesman', installer: 'installer' }

  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }

  has_many :appointments, dependent: :destroy
  has_many :jobs, foreign_key: 'salesman_id'

  has_many :crews_as_foreman, class_name: 'Crew', foreign_key: :foreman_id
  has_many :crews_as_laborer1, class_name: 'Crew', foreign_key: :laborer1_id
  has_many :crews_as_laborer2, class_name: 'Crew', foreign_key: :laborer2_id

  # Override email validation to be optional
  def email_required?
    false
  end

  # Override password validation to be optional
  def password_required?
    if new_record?
      password.present? || password_confirmation.present?
    else
      !password.blank?
    end
  end

  # Convert blank email to nil
  before_validation :normalize_email

  def super_admin?
    role == 'super_admin'
  end

  private

  def normalize_email
    self.email = nil if email.blank?
  end

  # Custom validation to skip password validation if not required
  validate :password_optional

  def password_optional
    if new_record? && (password.blank? || password_confirmation.blank?)
      errors.add(:password, "can't be blank") if password.present? && password_confirmation.blank?
      errors.add(:password_confirmation, "doesn't match Password") if password.present? && password_confirmation.present? && password != password_confirmation
    end
  end


end
