class CreateChartServices < ActiveRecord::Migration
  def change
    create_table :chart_services do |t|
      t.text :address

      t.timestamps
    end
  end
end
