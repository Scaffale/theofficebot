class AddFilename < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :file_name, :string
  end
end
