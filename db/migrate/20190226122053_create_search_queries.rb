class CreateSearchQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :search_queries do |t|
      t.string :tid
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :query

      t.timestamps
    end
  end
end
