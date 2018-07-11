class AddLimitToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, limit: 191
  end
end