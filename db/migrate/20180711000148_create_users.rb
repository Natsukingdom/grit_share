class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :mail
      t.string :password_digest
      t.date :birthday

      t.timestamps
    end
  end
end
