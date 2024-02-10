class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
