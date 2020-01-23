class AddControlFieldsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :error, :text
  end
end
