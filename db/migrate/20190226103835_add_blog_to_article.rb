class AddBlogToArticle < ActiveRecord::Migration[5.2]
  def up
    add_reference :articles, :blog, foreign_key: true
    #remove_column :articles, :blogs_id
  end
end
