class AddColumnToPomos < ActiveRecord::Migration[5.1]
  def change
    add_column :pomos, :passage_seconds, :integer
  end
end
