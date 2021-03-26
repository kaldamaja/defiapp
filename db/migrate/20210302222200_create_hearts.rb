class CreateHearts < ActiveRecord::Migration[6.1]
  def change
    create_table :hearts do |t|
	  t.belongs_to :comment, index: true
	  t.belongs_to :user, index: true
	  t.timestamps null: false

    end
  end
end
