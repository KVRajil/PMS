class Project < ApplicationRecord
  validates :title, presence: true,
                    uniqueness: { case_sensitive: false }, length: { maximum: 100 }

  belongs_to :user

  scope :ordered, -> { order(id: :asc) }
end
