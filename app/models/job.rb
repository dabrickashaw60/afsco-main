class Job < ApplicationRecord
  belongs_to :salesman, class_name: 'User'

  validates :job_number, presence: true, format: { with: /\A\d{2}-\d{5}\z/, message: "must be in the format ##-#####" }
  validates :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, presence: true
end
