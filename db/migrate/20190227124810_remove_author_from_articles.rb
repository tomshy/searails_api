# frozen_string_literal: true

class RemoveAuthorFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :author, :string
  end
end
