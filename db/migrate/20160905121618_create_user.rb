class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, unique: true
      t.string :firstname
      t.string :lastname
      t.string :password
      t.integer :account_type, default: 0
    end
  end
end
