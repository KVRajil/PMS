class Project < ApplicationRecord
  validates :title, presence: true,
                    uniqueness: { case_sensitive: false }, length: { maximum: 100 }

  has_many   :tasks, inverse_of: :project, dependent: :delete_all
  belongs_to :user,  inverse_of: :projects

  scope :ordered, -> { order(id: :asc) }
end
