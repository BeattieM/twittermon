class ChangePostCommentToString < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :comment, :string, limit: 140
  end
end
