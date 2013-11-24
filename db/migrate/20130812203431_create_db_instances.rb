class CreateDbInstances < ActiveRecord::Migration
  def change
    create_table :db_instances do |t|
      t.text :address

      t.timestamps
    end
  end
end
