class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.integer :season
      t.integer :episode
      t.integer :start_time
      t.integer :end_time
      t.text :text

      t.timestamps
    end
  end
end
