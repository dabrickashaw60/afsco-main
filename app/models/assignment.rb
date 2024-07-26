class Assignment < ApplicationRecord
  belongs_to :job

  validates :crew, presence: true
  validates :date, presence: true
end
