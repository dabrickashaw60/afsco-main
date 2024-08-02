class Job < ApplicationRecord
  belongs_to :salesman, class_name: 'User'
  belongs_to :crew, optional: true
  belongs_to :appointment, optional: true
  
  has_many :assignments, dependent: :destroy
  has_many_attached :files

  geocoded_by :full_address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :job_number, presence: true, uniqueness: true, format: { with: /\A\d{2}-\d{5}\z/, message: "must be in the format ##-#####" }
  validates :customer_name, :address, :customer_phone, :customer_email, :total_amount, presence: true
  validates :install_start_date, :install_end_date, presence: true, if: :installed?
  validates :type_of_work, presence: true, format: { with: /\A(PVC|Aluminum|Wood|Chain Link)(, (PVC|Aluminum|Wood|Chain Link))*\z/, message: "must be a comma-separated list of materials" }

  before_save :update_install_status_and_date

  def job_category
    return 'N/A' unless salesman.present?
    salesman.role.include?('residential') ? 'Residential' : 'Commercial'
  end

  def full_address
    [address, city, state, country].compact.join(', ')
  end

  def as_json(options = {})
    super(options).merge({
      job_number: job_number,
      salesman_id: salesman_id,
      customer_name: customer_name,
      address: address,
      customer_phone: customer_phone,
      customer_email: customer_email,
      total_amount: total_amount,
      type_of_work: type_of_work,
      installed: installed,
      crew: crew&.name,
      install_date: install_date,
      install_start_date: install_start_date,
      install_end_date: install_end_date,
      files: files.map { |file| { filename: file.filename.to_s, url: Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true) } }
    })
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
