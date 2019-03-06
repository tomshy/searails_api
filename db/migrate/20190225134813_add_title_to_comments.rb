# frozen_string_literal: true

class AddTitleToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :title, :string
  end
end
