class AddAddressToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :address, :string
  end
end
