class RemoveCommenterFromComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :commenter, :string
  end
end
