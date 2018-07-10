class CreatePomos < ActiveRecord::Migration[5.1]
  def change
    create_table :pomos do |t|
      t.datetime :start_time
      t.datetime :stop_time
      t.datetime :end_time
      t.string :comment

      t.timestamps
    end
  end
end
