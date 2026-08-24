class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.string :thumbnail
      t.text :caption
      t.string :discord_message_id
      t.string :discord_channel_id

      t.timestamps
    end
  end
end
