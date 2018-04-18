class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :user_id
      t.string :restaurant_id
      t.text :content
      t.decimal :angry
      t.decimal :sarcasm
      t.decimal :happy
      t.decimal :excited
      t.decimal :sad
      t.decimal :bored
      t.decimal :fear
      t.string :emotion
    end
  end
end
