class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :projects, inverse_of: :user, dependent: nil
  has_many :assigned_tasks,  class_name: 'Task', foreign_key: :assignee_id, inverse_of: :assignee, dependent: :delete_all
  has_many :reporting_tasks, class_name: 'Task', foreign_key: :reporter_id, inverse_of: :reporter, dependent: :delete_all

  scope :ordered, -> { order(id: :asc) }
end
