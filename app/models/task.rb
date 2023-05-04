class Task < ApplicationRecord
  include RansackSearch

  enum status: { todo: 0, doing: 1, done: 2 }
  validates :title, presence: true
  validates :status, presence: true
  validates :deadline, presence: true

  def self.status_value(status_key)
    statuses[status_key.to_s]
  end
  # validate :deadline, :must_start_from_today

  # def must_start_from_today
  #   errors.add(:deadline, 'must start from today.') if deadline.present? && deadline < Date.current
  # end
end
