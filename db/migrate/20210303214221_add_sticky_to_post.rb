class AddStickyToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :sticky, :boolean, default: false
  end
end
