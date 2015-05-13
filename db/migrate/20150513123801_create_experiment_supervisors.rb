class CreateExperimentSupervisors < ActiveRecord::Migration
  def change
    create_table :experiment_supervisors do |t|
      t.text :address
      t.timestamps
    end
  end
end
