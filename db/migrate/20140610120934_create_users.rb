class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: true do |t|
      t.string :token
      t.string :secret
    end
  end
end