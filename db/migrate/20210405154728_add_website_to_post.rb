class AddWebsiteToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :website, :text
  end
end
