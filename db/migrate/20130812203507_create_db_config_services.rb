class CreateDbConfigServices < ActiveRecord::Migration
  def change
    create_table :db_config_services do |t|
      t.text :address

      t.timestamps
    end
  end
end
