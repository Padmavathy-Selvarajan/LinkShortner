class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :given_url
      t.string :shortened_url

      t.timestamps null: false
    end
  end
end
