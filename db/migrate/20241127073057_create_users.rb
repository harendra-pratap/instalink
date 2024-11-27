class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.bigint :phone_number
      t.string :email
      t.string :password_digest
      t.string :device_language, null: false, default: "en"
      t.boolean :is_private, null: false, default: false
      t.timestamps
    end
  end
end
