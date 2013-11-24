class CreateStorageManagers < ActiveRecord::Migration
  def change
    create_table :storage_managers do |t|
      t.text :address

      t.timestamps
    end
  end
end
