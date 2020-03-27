class AddLocationIpAddressToClicks < ActiveRecord::Migration[5.0]
  def change
  	add_column :clicks, :ip_address, :string
  	add_column :clicks, :country, :string
  end
end
