# frozen_string_literal: true

class CreateJwtDenylist < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false, index: true
      t.datetime :exp, null: false
    end
  end
end
