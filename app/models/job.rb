class Job < ApplicationRecord
  belongs_to :salesman, class_name: 'User'
  belongs_to :crew, optional: true
  has_many :assignments, dependent: :destroy

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :job_number, presence: true, format: { with: /\A\d{2}-\d{5}\z/, message: "must be in the format ##-#####" }
  validates :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, presence: true
  validates :install_start_date, :install_end_date, presence: true, if: :installed?

  before_save :update_install_status_and_date

  def full_address
    [address, city, state, country].compact.join(', ')
  end

  private

  def update_install_status_and_date
    if install_end_date.present? && install_end_date < Date.today
      self.installed = true
      self.install_date = "#{install_start_date} - #{install_end_date}"
    else
      self.installed = false
      self.install_date = nil
    end
  end
end
