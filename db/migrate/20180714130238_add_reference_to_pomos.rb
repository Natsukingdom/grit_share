class AddReferenceToPomos < ActiveRecord::Migration[5.1]
  def change
    add_reference :pomos, :user, foregin_key: true
  end
end
