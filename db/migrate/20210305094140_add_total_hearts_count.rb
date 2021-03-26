class AddTotalHeartsCount < ActiveRecord::Migration[6.1]
  def change
	add_column :comments, :hearts_count, :integer, :default => 0
  end
end
