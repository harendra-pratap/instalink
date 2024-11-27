class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.text :original_message
      t.text :translated_message
      t.string :language
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
