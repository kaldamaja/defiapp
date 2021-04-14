class AddBscscanToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :bscscan, :text
  end
end
