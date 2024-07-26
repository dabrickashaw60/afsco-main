class Job < ApplicationRecord
  belongs_to :salesman, class_name: 'User'
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :job_number, presence: true, format: { with: /\A\d{2}-\d{5}\z/, message: "must be in the format ##-#####" }
  validates :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, presence: true
  validates :install_start_date, :install_end_date, presence: true, if: :installed?
  has_many :assignments

  # Method to check if the job is completed
  def update_installation_status
    if install_end_date.present? && install_end_date < Date.today
      update(installed: true)
    end
  end

  def full_address
    [address, city, state, country].compact.join(', ')
  end


end
