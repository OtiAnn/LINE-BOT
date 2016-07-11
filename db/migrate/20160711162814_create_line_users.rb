class CreateLineUsers < ActiveRecord::Migration
  def change
    create_table :line_users do |t|
      t.string :user_mid

      t.timestamps null: false
    end
  end
end
