class Job < ApplicationRecord
  belongs_to :salesman, class_name: 'User'
  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :job_number, presence: true, format: { with: /\A\d{2}-\d{5}\z/, message: "must be in the format ##-#####" }
  validates :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, presence: true

  def full_address
    [address, city, state, country].compact.join(', ')
  end


end
