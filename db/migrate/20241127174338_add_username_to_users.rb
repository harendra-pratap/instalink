class AddUsernameToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :username, :string
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
    add_column :follows, :status, :string, default: 'pending', null: false
  end
end
