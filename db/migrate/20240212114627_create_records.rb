class CreateRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :records do |t|
      t.belongs_to :feedback, null: false, foreign_key: true
      t.string :source_ip
      t.integer :count
      t.json :policy_evaluated
      t.json :identifiers
      t.json :auth_results

      t.timestamps
    end
  end
end
