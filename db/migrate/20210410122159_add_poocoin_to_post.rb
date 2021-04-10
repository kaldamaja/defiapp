class AddPoocoinToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :poocoin, :text
  end
end
