class CreateDbRouters < ActiveRecord::Migration
  def change
    create_table :db_routers do |t|
      t.text :address

      t.timestamps
    end
  end
end
