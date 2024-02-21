class AddNameToJob < ActiveRecord::Migration[7.1]
  def change
    change_table :jobs do |t|
      t.string :name
    end
  end
end
