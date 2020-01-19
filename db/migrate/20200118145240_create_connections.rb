class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.string :provider
      t.string :oauth_token
      t.string :secret
      t.integer :user_id

      t.timestamps
    end
  end
end
