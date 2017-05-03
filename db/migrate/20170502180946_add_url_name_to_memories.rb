class AddUrlNameToMemories < ActiveRecord::Migration[5.1]
  def change
    add_column :memories, :name, :string
    add_column :memories, :url, :string
  end
end
