class Appointment < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :title, :start_time, :end_time, presence: true
  validate :end_time_after_start_time
  belongs_to :job, optional: true

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
