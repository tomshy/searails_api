class RemoveBlogsidFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :blogs_id, :integer
  end
end
