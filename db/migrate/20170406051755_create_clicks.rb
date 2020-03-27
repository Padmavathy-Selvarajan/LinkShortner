class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
    	t.integer :user_id
    	t.integer :link_id
    	t.integer :count, default: 0, null: false

      t.timestamps null: false
    end
  end
end
