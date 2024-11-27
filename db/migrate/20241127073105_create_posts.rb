class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :image_path
      t.string :location
      t.float :sentiment_score
      t.string :sentiment_type
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
