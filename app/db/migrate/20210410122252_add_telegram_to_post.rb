class AddTelegramToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :telegram, :text
  end
end
