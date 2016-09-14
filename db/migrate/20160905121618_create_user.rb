class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :password
      t.integer :account_type, default: 0
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
