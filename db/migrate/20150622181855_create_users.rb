class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :staff
      t.string :spire

      t.timestamps null: false
    end
  end
end
