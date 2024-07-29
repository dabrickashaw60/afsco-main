class Assignment < ApplicationRecord
  belongs_to :job
  belongs_to :crew

  validates :crew, presence: true
  validates :date, presence: true
end
