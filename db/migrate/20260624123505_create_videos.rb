class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :caption
      t.string :youtube_id
      t.string :discord_message_id
      t.string :discord_channel_id

      t.timestamps
    end
  end
end
