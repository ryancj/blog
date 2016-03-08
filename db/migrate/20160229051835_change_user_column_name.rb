class ChangeUserColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :password_diggest, :password_digest
  end
end
