class CreateExperimentManagers < ActiveRecord::Migration
  def change
    create_table :experiment_managers do |t|
      t.text :address

      t.timestamps
    end
  end
end
