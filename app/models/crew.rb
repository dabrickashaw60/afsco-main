class Crew < ApplicationRecord
  has_many :jobs
  belongs_to :foreman, class_name: 'User', optional: true
  belongs_to :laborer1, class_name: 'User', optional: true
  belongs_to :laborer2, class_name: 'User', optional: true

  validates :name, presence: true
  validate :unique_members

  def unique_members
    member_ids = [foreman_id, laborer1_id, laborer2_id].compact
    if member_ids.uniq.size != member_ids.size
      errors.add(:base, "Crew members must be unique")
    end
  end
end
