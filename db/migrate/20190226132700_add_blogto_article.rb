class AddBlogtoArticle < ActiveRecord::Migration[5.2]
  def change
  	add_reference :articles, :blog, foreign_key: true
  end
end
