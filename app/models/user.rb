class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_many :projects
end
