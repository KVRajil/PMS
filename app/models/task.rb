class Task < ApplicationRecord
  STATUSES = %w[yet_to_start in_progress completed].freeze

  validates :title, presence: true, length: { maximum: 200 }
  validates :title, uniqueness: { scope: :project }
  validates :status, inclusion: { in: STATUSES }, allow_nil: true

  belongs_to :project, inverse_of: :tasks
  belongs_to :assignee, class_name: 'User', inverse_of: :assigned_tasks, optional: true
  belongs_to :reporter, class_name: 'User', inverse_of: :reporting_tasks, optional: true

  scope :ordered, -> { order(id: :asc) }
end
