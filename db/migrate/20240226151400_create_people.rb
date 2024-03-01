class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.belongs_to :account, foreign_key: true

      t.timestamps
    end
  end
end
