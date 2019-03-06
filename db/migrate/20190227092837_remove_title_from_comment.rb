# frozen_string_literal: true

class RemoveTitleFromComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :title, :string
  end
end
